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