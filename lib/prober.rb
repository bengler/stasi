#encoding: UTF-8
require 'term/ansicolor'
class String
  include Term::ANSIColor
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
