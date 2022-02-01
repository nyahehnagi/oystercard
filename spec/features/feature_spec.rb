# frozen_string_literal: true

require_relative '../../lib/oystercard'

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.
describe "User Story 6:" do
  it "should raise an error" do
    oyster_card = OysterCard.new
    expect{oyster_card.touch_in}.to raise_error "Insufficient funds on card"
  end
end

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card
describe "User Story 7:" do
  it "should reduce the balance after touching out" do
    oyster_card = OysterCard.new(20)
    oyster_card.touch_in
    oyster_card.touch_out
    expect(oyster_card.balance).to eq 19
  end
end