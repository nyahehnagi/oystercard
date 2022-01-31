# frozen_string_literal: true

require_relative '../lib/oystercard'

p "new card, default balance:  #{card = OysterCard.new}"
p "default balance:  #{card.balance}"
p "top up card: #{card.top_up(1)}"
p "balance after top up = 1:  #{card.balance}"

p "new card, default balance:  #{card_one = OysterCard.new(1)}"
p "balance = 1:  #{card_one.balance}"
p "top up card: #{card_one.top_up(1)}"
p "balance after top up = 2:  #{card_one.balance}"

begin 
p "new card, default balance:  #{card_one = OysterCard.new}"
p "balance = 1:  #{card_one.balance}"
p "top up card: #{card_one.top_up(91)}"
rescue => exception
  puts "Error Message: #{exception.message}"
end

p "testing deduct"
p "new card, balance of 1:  #{card = OysterCard.new(1)}"
p "balance = 1:  #{card.balance}"
p "deduct 1 from card: #{card.deduct_fare(1)}"
p "balance = 0:  #{card.balance}"

p "new card, default balance:  #{card = OysterCard.new}"
p "touch in card:   #{card.touch_in}"
p "is card on a journey?    #{card.in_journey?}"
p "touch out card: #{card.touch_out}"
p "card is not on a journey:    #{card.in_journey?}"