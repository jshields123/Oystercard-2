require_relative 'journey'

class OysterCard

   CARD_LIMIT = 90


    attr_accessor :active
    attr_reader :journey_list, :current_journey, :balance


    private
    attr_writer :balance

    public

    def initialize
        @balance = 0
        @journey_list = []
        @current_journey = nil
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
      @balance += amount
    end


    def touch_in(station)
      fail "Not enough money on card" if @balance < Journey::MINIMUM_FARE
       touch_out("penalty_fee") if current_journey != nil
      @current_journey = Journey.new(entry_station: station)
    end

    def touch_out(station)
      touch_in("penalty_fee") if current_journey == nil
      @current_journey.exit_station = station
    end_journey
    end

    def end_journey
      deduct(current_journey.calculate_fare)
      @journey_list << current_journey
      @current_journey = nil
    end

    private

    def deduct(amount)
      @balance -= amount
    end

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end

end
