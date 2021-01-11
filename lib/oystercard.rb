class OysterCard
    attr_reader :balance

    private
    attr_writer :balance

    public
    
    def initialize
        @balance = 15
    end
    
    def top_up(amount)
        self.balance = balance + amount
    end

end