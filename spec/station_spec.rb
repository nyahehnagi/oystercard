require_relative '../lib/station'

describe Station do

  subject(:station) { described_class.new("Holborn") }
  
  describe "#name" do
    it "should have a station name" do
      expect(station.name).to eq "Holborn" 
    end
  end
  
end