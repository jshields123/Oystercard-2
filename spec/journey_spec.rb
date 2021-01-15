require 'journey'


describe Journey do
let(:station) { double :station, zone: 1}
subject {described_class.new(entry_station: station)}
it "knows if a journey is not complete" do
    expect(subject).to be_in_journey
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
end

  it 'has penalty fare if touch on without tap in' do
    journey = Journey.new(entry_station: "penalty_fee")
    expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
  end

context 'given an entry station' do


  it 'has an entry station' do
    expect(subject.entry_station).to eq station
  end

  it "returns a penalty fare if no exit station given" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  context 'given an exit station' do
    let(:other_station) { double :other_station }


    it 'calculates a fare' do
      subject.exit_station = other_station
      expect(subject.calculate_fare).to eq 1
    end

    it "knows if a journey is complete" do
      subject.exit_station = other_station
      expect(subject).not_to be_in_journey
    end
  end
end

end
