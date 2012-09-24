#encoding: UTF-8
require 'term/ansicolor'
class String
  include Term::ANSIColor
end

class PidMonitor

  def initialize(pid, mem_tracer, max_line)
    @opts = opts
    @graphics = graphics
    @name = opts[:name] || "Process ##{pid}"
    @prober = Prober.new(pid)
  end

  def probe
    @prober.probe
    refresh
  end

  def colorize(str)
    return str.send(@opts[:color]) if @opts[:color]
    str
  end

  def refresh
    #@mem_trace.move_left
    #@mem_trace.draw(60, 3 + @opts[:height] - (@opts[:height]/@prober.usage).to_i, colorize('·'))
    #@mem_trace.draw(62, 3, colorize("#{@name} #{@prober.usage.round(2)}MB"))
    @max_line.text(0, 3, colorize(('-'*60)))
    @graphics.paint(@max_line)
  end
end

class Prober
  attr_reader :pid, :prev_usage, :usage, :max_usage
  def initialize(pid)
    @pid, @max_usage, @prev_usage, @usage = pid, 0, 0, 0
  end

  def probe
    @prev_usage = @usage
    @usage = (`ps -o rss= -p #{pid}`.to_f/1024.0)
    if @usage > @max_usage
      @max_usage = @usage
    end
  end
end
