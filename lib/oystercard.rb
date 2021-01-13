class OysterCard

   CARD_LIMIT = 90
   MINIMUM_FARE = 1

    attr_reader :balance
    attr_accessor :active
    attr_reader :entry_station

    private
    attr_writer :balance

    public

    def initialize
        @balance = 0

    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount
    end

    def touch_in(entrystation)
      fail "Not enough money on card" if @balance < MINIMUM_FARE
      @entry_station = entrystation

    end

    def touch_out


      deduct(amount = MINIMUM_FARE)
      @entry_station = nil
    end

    def in_journey?
       @entry_station == nil ? false : true

    end

    def balance_check
    end


    private

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end

end
