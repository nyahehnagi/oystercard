require_relative '../lib/card'

p "new card, default balance:  #{card = Card.new}"
p "default balance:  #{card.balance}"
p "new card, default balance:  #{card_one = Card.new(1)}"
p "balance = 1:  #{card_one.balance}"