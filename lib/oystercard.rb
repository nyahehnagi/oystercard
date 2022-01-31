# frozen_string_literal: true

# class describes an Oystercard
class OysterCard
  
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Cannot exceed a balance of £#{BALANCE_LIMIT}" if limit_exceeded(amount)
    @balance += amount
  end

  private

  def limit_exceeded(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
