# frozen_string_literal: true

require_relative '../../lib/oystercard'
require_relative '../../lib/station'

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.
describe "User Story 6:" do
  it "should raise an error" do
    oyster_card = OysterCard.new
    expect{oyster_card.touch_in(Station.new("Holborn"))}.to raise_error "Insufficient funds on card"
  end
end

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card
describe "User Story 7:" do
  it "should reduce the balance after touching out" do
    oyster_card = OysterCard.new(20)
    oyster_card.touch_in(Station.new("Holborn"))
    oyster_card.touch_out(Station.new("Liverpool Street"))
    expect(oyster_card.balance).to eq 19
  end
end

# In order to pay for my journey
# As a customer
# I need to know where I've travelled from

describe "User Story 8:" do
  it "stores the entry station after touch in" do
    oyster_card = OysterCard.new(1)
    entry_station = Station.new("Holborn")
    oyster_card.touch_in(entry_station)
    expect(oyster_card.entry_station.name).to eq entry_station.name
  end

  it "has nil entry station after touch out" do
    oyster_card = OysterCard.new(1)
    entry_station = Station.new("Holborn")
    oyster_card.touch_in(entry_station)
    oyster_card.touch_out(Station.new("liverpool Street"))
    expect(oyster_card.entry_station).to be_nil
  end
end

# In order to know where I have been
# As a customer
# I want to see all my previous trips
describe "User Story 9" do
  xit "stores a list of journeys" do
    oyster_card = OysterCard.new(1)
    entry_station = Station.new("Holborn")
    exit_station = Station.new("Liverpool Street")
    oyster_card.touch_in(entry_station)
    oyster_card.touch_out(exit_station)
    expect(oyster_card.journeys).to eq [{entry_station => exit_station}]
  end

end