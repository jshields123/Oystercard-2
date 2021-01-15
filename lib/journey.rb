require_relative 'oystercard'

class Journey
  attr_reader :journey_list, :entry_station, :fare
  attr_accessor :exit_station
  PENALTY_FARE = 3
  MINIMUM_FARE = 1

  def initialize(entry_station:)
    @entry_station = entry_station
    @exit_station = nil
    @fare = 3
   end

  def in_journey?
    exit_station == nil
  end

  # def finish(station)
  #   @fare = 1
  #   @in_journey = false
  #   self
  # end

  def calculate_fare
  @fare = (exit_station == "penalty_fee" || entry_station == "penalty_fee") ? PENALTY_FARE : MINIMUM_FARE
  end

end
