require 'oystercard'

describe OysterCard do

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(subject.balance).to be_an(Numeric)
        end

        it 'has an empty list of journeys by default' do
            expect(subject.journey_list).to be_empty
          end

    end

    describe '#top_up' do

        it 'increases the balance with the amount passed as an argument' do
            expect{ subject.top_up 15 }.to change{ subject.balance }.by 15
        end

        it "raises an exception when the new balance exceeds the limit" do
          subject.top_up(described_class::CARD_LIMIT)
          expect { subject.top_up 1 }.to raise_error "Card limit of £#{described_class::CARD_LIMIT} reached"
        end
    end

    describe "#touch in" do
      it "does not touch in unless balance has minimum fare" do
        expect{ subject.touch_in("entrystation") }.to raise_error "Not enough money on card"
      end
    end

    describe '#touch out' do
      before do
        subject.top_up(described_class::CARD_LIMIT)
        subject.touch_in(entry_station)
      end
      let(:exit_station) { double("Baker Street") }
      let(:entry_station) { double("Bank") }
    it 'deduct the minimum fare after touch out' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(- Journey::MINIMUM_FARE)
    end

    # it 'forgets entrystation' do
    #   subject.touch_in(entry_station)
    #   expect { subject.touch_out(exit_station) }.to change{ subject.entry_station }.to(nil)
    # end

    it 'stores exit station' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_list[-1].exit_station).to eq exit_station
    end

  end


  describe '#entry station' do
    it 'stores entry station' do
      station = double("Willesden Green")
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.current_journey.entry_station).to eq station
  end
end


  describe '#journey' do
    let(:entry_station) { double("Willesden Green") }
    let(:exit_station) { double("Baker Street") }
    it 'stores the most recent journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_list[-1]).to be_a Journey
    end
  end

end
