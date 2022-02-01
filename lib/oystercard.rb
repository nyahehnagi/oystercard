# frozen_string_literal: true

# class describes an Oystercard
class OysterCard
  
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise "Cannot exceed a balance of £#{BALANCE_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds on card" if insufficient_funds?
    @entry_station = entry_station
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @entry_station = nil
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
