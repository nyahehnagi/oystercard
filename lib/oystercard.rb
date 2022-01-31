# frozen_string_literal: true

# class describes an Oystercard
class OysterCard
  DEFAULT_BALANCE = 0
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    @balance += money
  end
end
