require 'oystercard'

describe OysterCard do

    # it { is_expected.to respond_to(:balance) }

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(subject.balance).to be_an(Numeric)
        end

    end

    describe '#top_up' do

        it 'increases the balance with the amount passed as an argument' do
            subject.top_up(15)
            expect(subject.balance).to eq 15
        end

        it "raises an exception when the new balance exceeds the limit" do
          card = OysterCard.new
          card.top_up(described_class::CARD_LIMIT)
          expect { card.top_up(1) }.to raise_error "Card limit of £#{described_class::CARD_LIMIT} reached"
        end
    end

    describe '#deduct' do

      it 'deducts amount from the balance of the card' do
        subject.top_up(15)
        expect{ subject.deduct(5) }.to change{ subject.balance}.by -5
      end
    end

    describe "#touch in" do
      it "does not touch in unless balance has minimum fare" do
        expect{ subject.touch_in("entrystation") }.to raise_error "Not enough money on card"
      end
    end

    describe '#touch out' do
      before do
        subject.top_up(5)
        subject.touch_in("entrystation")
      end
      let(:exit_station) { double("Baker Street") }

    it 'deduct the minimum fare after touch out' do
      # subject.top_up(5)
      # subject.touch_in
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-1)
    end

    it 'forgets entrystation' do
      expect { subject.touch_out(exit_station) }.to change{ subject.entry_station }.to(nil)
    end

  end

  # describe '#in journey or not' do
  #   before do
  #     subject.top_up(5)
  #     subject.touch_in("entrystation")
  #   end
  #   it "is in journey after touch in" do
  #     # subject.top_up(5)
  #     # subject.touch_in
  #     expect(subject).to be_in_journey
  #   end
  #
  #   it "is not in journey after touch out" do
  #     # subject.top_up(5)
  #     # subject.touch_in
  #     exit_station = double("Baker Street")
  #     subject.touch_out(exit_station)
  #     expect(subject).not_to be_in_journey
  #   end
  # end

  describe '#entry station' do
    it 'stores entry station' do
      station = double("Willesden Green")
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
  end
end

  describe '#journey' do
    let(:entry_station) { double("Willesden Green") }
    let(:exit_station) { double("Baker Street") }
    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
    it 'stores the most recent journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey).to eq journey
    end
  end

end
