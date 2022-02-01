# frozen_string_literal: true

# class describes an Oystercard
class OysterCard
  
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot exceed a balance of £#{BALANCE_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient funds on card" if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @in_journey = false
  end
  
  private
  def deduct_fare(fare)
    @balance -= fare
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def limit_exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
