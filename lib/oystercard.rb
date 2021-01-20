class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "£#{MAX_BALANCE} limit reached" if @balance >= 90
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < 1
    @entry_station = station
  end

  def touch_out
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  def in_journey
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
