require_relative 'oystercard'

class Journey
  attr_reader :journey_list, :station, :fare, :in_journey

  PENALTY_FARE = 3

  def initialize(entry_station: station)
    @journey_list = []
    @in_journey = true
    @station = entry_station
    @fare = PENALTY_FARE
   end

  def in_journey?
    @in_journey
  end

  def finish(station)
    @fare = 1
    @in_journey = false
    self
  end


end
