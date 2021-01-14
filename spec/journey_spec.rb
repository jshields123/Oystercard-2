require 'journey'
require 'oystercard'

describe Journey do
card = OysterCard.new

  describe "initialize" do
    it 'has an empty list of journeys' do
      expect(subject.journey_list).to eq []
    end
  end

  describe '#touch in' do
    it "changes in journey to true" do
      card.top_up(5)
      card.touch_in("entrystation")
      expect(subject.in_journey).to eq true
    end
  end

  describe "touch out" do
    it 'changes in journey to false' do
      card.top_up(5)
      card.touch_in("entrystation")
      card.touch_out("exit_station")
      expect(subject.in_journey).to eq false
    end
  end

end
