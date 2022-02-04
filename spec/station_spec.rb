require_relative '../lib/station'

describe Station do

  subject(:station) { described_class.new("Holborn", 1) }
  
  describe "#name" do
    it "should have a station name" do
      expect(station.name).to eq "Holborn" 
    end
  end

  describe "#zone" do
    it "should have a zone" do
      expect(station.zone).to eq 1
    end
  end
  
end