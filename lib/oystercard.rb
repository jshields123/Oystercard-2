require_relative 'journey'

class OysterCard

   CARD_LIMIT = 90
   MINIMUM_FARE = 1

    attr_accessor :active
    attr_reader :entry_station, :journey_list, :journey, :balance, :exit_station


    private
    attr_writer :balance

    public

    def initialize
        @balance = 0
        @journey_list = []
        @journey = {}
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
      @balance += amount
    end


    def touch_in(entrystation)
      fail "Not enough money on card" if @balance < MINIMUM_FARE
      @entry_station = entrystation

    end

    def touch_out(exit_station)
      deduct(MINIMUM_FARE)
      @journey = {:entry_station => @entry_station, :exit_station => exit_station}
      @entry_station = nil
      @exit_station = exit_station
      @journey_list << journey
    end

    private

    def deduct(amount)
      @balance -= amount
    end

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end

end
