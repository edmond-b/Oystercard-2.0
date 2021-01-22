class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "£#{MAX_BALANCE} limit reached" if @balance >= 90
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < 1
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @exit_station = station
    store_journey(@entry_station, @exit_station)
    reset_stations
  end

  def in_journey
    !!entry_station
  end

  private
  def reset_stations
    @entry_station = nil
    # @exit_station = nil
  end

  def store_journey(entry, exit)
    @journeys << {:entry_station => entry, :exit_station => exit}
  end

  def deduct(amount)
    @balance -= amount
  end
end
