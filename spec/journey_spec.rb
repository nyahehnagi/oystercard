require 'journey'

describe Journey do

  let(:entry_station) { double(:entry_station)}
  let(:exit_station) { double(:exit_station)}
  
  subject(:journey) { described_class.new(entry_station, exit_station) }


  describe "initialise" do
    it "has an entry station" do
      expect(journey.entry_station).to eq entry_station
    end

    it "has an exit station" do
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe "#calculate_fare" do
    it "calculates the fare of a complete journey" do
      expect(journey.calculate_fare).to eq 1
    end

    it "calculates a penalty fare for an incomplete journey" do
      journey = described_class.new(entry_station, nil)
      expect(journey.calculate_fare).to eq 6
    end

    it "calculates a penalty fare of 0 if entry and exit stations equal nil" do
      journey = described_class.new
      expect(journey.calculate_fare).to eq 0
    end

  end

  describe "in_journey?" do
    it "is in a journey" do
      journey = described_class.new(entry_station)
      expect(journey.in_journey?).to eq true
    end
  end
end