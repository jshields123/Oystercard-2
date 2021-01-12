require 'oystercard'

describe OysterCard do

    it { is_expected.to respond_to(:balance) }

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

    describe 'deduct' do

      it 'deducts amount from the balance of the card' do
        subject.top_up(15)
        expect{ subject.deduct(5) }.to change{ subject.balance}.by -5
      end
    end

    describe 'touch in' do

      it { is_expected.to respond_to(:touch_in) }

      it "changes active to true" do
        subject.touch_in
        expect(subject.active).to eq true
      end
      
    end

end
