# frozen_string_literal: true

require_relative '../../lib/oystercard'
require_relative '../../lib/station'
require_relative '../../lib/journey'

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.
describe "User Story 6:" do
  it "should raise an error" do
    oyster_card = OysterCard.new(Journey)
    expect{oyster_card.touch_in(Station.new("Holborn",1))}.to raise_error "Insufficient funds on card"
  end
end

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card
describe "User Story 7:" do
  it "should reduce the balance after touching out" do
    oyster_card = OysterCard.new(Journey, 20)
    oyster_card.touch_in(Station.new("Holborn" , 1))
    oyster_card.touch_out(Station.new("Liverpool Street", 1))
    expect(oyster_card.balance).to eq 19
  end
end

# In order to pay for my journey
# As a customer
# I need to know where I've travelled from

describe "User Story 8:" do
  it "stores the entry station after touch in" do
    oyster_card = OysterCard.new(Journey, 1)
    entry_station = Station.new("Holborn", 1)
    oyster_card.touch_in(entry_station)
    expect(oyster_card.current_journey.entry_station).to eq entry_station
  end

  it "has nil entry station after touch out" do
    oyster_card = OysterCard.new(Journey, 1)
    entry_station = Station.new("Holborn" , 1)
    oyster_card.touch_in(entry_station)
    oyster_card.touch_out(Station.new("liverpool Street", 1))
    expect(oyster_card.entry_station).to be_nil
  end
end

# In order to know where I have been
# As a customer
# I want to see all my previous trips
describe "User Story 9" do
  it "stores a list of journeys" do
    oyster_card = OysterCard.new(Journey, 1)
    entry_station = Station.new("Holborn", 1)
    exit_station = Station.new("Liverpool Street", 1)
    oyster_card.touch_in(entry_station)
    journey = oyster_card.current_journey
    oyster_card.touch_out(exit_station)
    expect(oyster_card.journeys).to eq [journey]
  end

end

# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in
describe "User Story 10 - Station Class" do
  it "has a name" do
    station = Station.new("Liverpool Street", 1)
    expect(station.name).to eq "Liverpool Street"
  end

  it "has a zone" do
    station = Station.new("Liverpool Street", 1)
    expect(station.zone).to eq 1
  end
end

# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
describe "User Story 11 - Penalty fares" do
  it "has an entry station" do
    entry_station = Station.new("Leytonstone", 3)
    exit_station = Station. new("Liverpool Street", 1)
    journey = Journey.new(entry_station, exit_station)
    expect(journey.entry_station).to eq entry_station
  end

  it "calculates a fare for a complete journey" do
  end
  it "calculates a penalty fare for an incomplete journey" do
  end
  
end