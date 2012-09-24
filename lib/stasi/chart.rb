require 'thread'

module Terminal
  class Layout
    attr_reader :layers
    def initialize(&blk)
      @layers = []
      blk.call(self) if block_given?
    end
    def add_layer(layer)
      @layers << layer
    end
    def paint(graphics)
      @layers.each do |layer|
        graphics.paint(layer)
      end
    end
  end

  class Layer

    attr_accessor :opaque, :top, :left, :height, :width, :space

    def initialize(opts, &blk)
      @opts = opts.dup
      @width, @height, @top, @left = opts[:width], opts[:height], (opts[:top] || 0), (opts[:left] || 0)
      @opaque = !!opts[:opaque]
      raise "Missing required options :with and :height" unless width and height
      fill!(nil)
      blk.call self if block_given?
    end

    def text(x, y, str)
      @space[x][y] = str
    end

    def paint(graphics)
      graphics.paint(self)
    end

    def fill!(chr='')
      @space = Array.new(width) { Array.new(height, chr) }
    end

    def resize!(r_height, r_width)
      @space = resize(r_height, r_width).space
    end

    def resize(r_height, r_width)
      height_ratio = r_height.to_f/@height.to_f
      width_ratio = r_width.to_f/@width.to_f
      new_layer = Layer.new(@opts.merge(height: r_height, width: r_width))
      space.each_index do |x|
        space[x].each_index do |y|
          r_x, r_y = (x*width_ratio).floor, (y*height_ratio).floor
          new_layer.space[r_x][r_y] = space[x][y]
        end
      end
      new_layer
    end

    def move_left(steps=1)
      steps.times {
        @space.shift
        @space[width-1] = Array.new(height, nil)
      }
    end
    def move_down(steps=1)
      @space.each do |x|
        x.unshift(*(steps.times.map { nil }))
        x.slice!(-steps)
      end
    end
  end

  class TerminalGraphics
    def initialize(top=0, left=0)
      @top, @left = top, left
      @mutex = Mutex.new
    end

    def paint(layer)
      _paint(layer)
    end

    def prepare
      clear
      print "\033[0;0f"
      print "\033[?25l"
    end

    def reset
      clear
      # Show cursor
      print "\033[?25h"
      print "\033[0;0f"
    end

    def clear
      # Clear the screen, move to (0,0) (http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html)
      print "\033[2J"
    end

    private
    def _paint(layer)
      @mutex.synchronize {
        layer.space.each_index do |x|
          layer.space[x].each_index do |y|
            move_cursor(layer.left+x, layer.top+y)
            print (layer.space[x][y] || ' ').to_s if layer.space[x][y] || layer.opaque
          end
        end
      }
    end

    def move_cursor(x, y)
      # Position the Cursor (http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html)
      print "\033[#{@top+1+y};#{@left+1+x}f"
    end

  end
end