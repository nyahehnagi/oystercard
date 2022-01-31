# frozen_string_literal: true

# class describes an Oystercard
class OysterCard
  
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot exceed a balance of £#{BALANCE_LIMIT}" if limit_exceeded(amount)
    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
  
  private

  def limit_exceeded(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
