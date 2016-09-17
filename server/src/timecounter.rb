class TimeBasedCounter
  def initialize(interval, clock)
    @interval = interval
    @clock = clock
  end

  def get
    ((@clock.now - @clock.at(0)).to_i / @interval).to_s
  end
end
