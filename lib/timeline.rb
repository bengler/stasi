require "ostruct"
class Timeline < Array
  attr_reader :name
  def initialize(pid, name=nil)
    @pid, @name = pid, name
    @name ||= "Process ##{pid}"
  end

  def probe
    usage = (`ps -o rss= -p #{@pid}`.to_f/1024.0)
    self << OpenStruct.new(
      usage: usage
    )
  end

  def trend
    return :pending if size < 2
    last.usage > self[-2].usage ? :growing : :stable
  end

end
