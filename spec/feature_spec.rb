require_relative '../lib/oystercard'

p "new card, default balance:  #{card = OysterCard.new}"
p "default balance:  #{card.balance}"
p "new card, default balance:  #{card_one = OysterCard.new(1)}"
p "balance = 1:  #{card_one.balance}"