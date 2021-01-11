require 'oystercard'

describe OysterCard do

    it { is_expected.to respond_to(:balance) }

    describe 'initialization' do

        it 'has a numeric balance' do
            expect(subject.balance).to be_an(Numeric)
        end

    end

    describe '#top_up' do

        it { is_expected.to respond_to(:top_up).with(1).argument }

        it 'increases the balance with the amount passed as an argument' do
            card = OysterCard.new
            card.top_up(15)
            expect(card.balance).to eq 15
        end

    end

end
