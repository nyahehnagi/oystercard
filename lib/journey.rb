class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  NO_FARE = 0
  
  attr_accessor :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def calculate_fare
    return NO_FARE if @entry_station.nil? && @exit_station.nil?
    return PENALTY_FARE if @entry_station.nil? || @exit_station.nil? 
    MINIMUM_FARE
  end

  def in_journey?
    !@entry_station.nil? && @exit_station.nil?
  end

end