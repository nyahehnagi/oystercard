# frozen_string_literal: true
require_relative '../lib/journey'
# class describes an Oystercard
class OysterCard
  
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize(journey_class = Journey, balance = DEFAULT_BALANCE)
    @journey_class = journey_class
    @balance = balance
    @entry_station = nil
    @journeys = []
    @current_journey = journey_class.new
  end

  def top_up(amount)
    raise "Cannot exceed a balance of £#{BALANCE_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end

  # def in_journey?
  #   @current_journey.in_journey?
  # end

  def touch_in(entry_station)
    raise "Insufficient funds on card" if insufficient_funds?
    deduct_fare(@current_journey.calculate_fare)
    @current_journey = @journey_class.new(entry_station)
  end

  def touch_out(exit_station)
    @current_journey.exit_station = exit_station
    deduct_fare(@current_journey.calculate_fare)
    add_journey(exit_station)
    @current_journey = @journey_class.new
  end
  
  private

  def add_journey(exit_station)
    journeys << @current_journey
  end

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
