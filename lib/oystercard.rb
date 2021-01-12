class OysterCard

   CARD_LIMIT = 90

    attr_reader :balance
    attr_accessor :active

    private
    attr_writer :balance

    public

    def initialize
        @balance = 0
        @active = false
    end

    def top_up(amount)
      fail "Card limit of £#{CARD_LIMIT} reached" if limit_exceeded?(amount)
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount
    end

    def touch_in
      @active = true
    end

    private

    def limit_exceeded?(amount)
      balance + amount > CARD_LIMIT
    end

end
