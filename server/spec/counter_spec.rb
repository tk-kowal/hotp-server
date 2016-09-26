require 'rspec'
require_relative '../src/timecounter.rb'

class MockClock
  attr_reader :now

  def initialize(horizon, now)
    @horizon = horizon
    @now = now
  end

  def at(unimportant)
    @horizon
  end
end

describe TimeBasedCounter do
  let(:interval) { 10 }
  let(:horizon) { Time.at(0) }

  context 'beginning of time' do
    let(:now)     { Time.at(0) }
    it 'reports 0 intervals since the beginning of time' do
      clock = MockClock.new(horizon, now)
      subject = TimeBasedCounter.new(interval, clock)
      expect(subject.get).to eq 0
    end
  end

  context 'beginning of time + half an interval' do
    let(:now)     { horizon + (interval / 2) }
    it 'reports 0 intervals since the beginning of time' do
      clock = MockClock.new(horizon, now)
      subject = TimeBasedCounter.new(interval, clock)
      expect(subject.get).to eq 0
    end
  end

  context 'beginning of time + one interval' do
    let(:now)     { horizon + interval }
    it 'reports 0 intervals since the beginning of time' do
      clock = MockClock.new(horizon, now)
      subject = TimeBasedCounter.new(interval, clock)
      expect(subject.get).to eq 1
    end
  end
end
