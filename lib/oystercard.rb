class Oystercard
  attr_reader :balance, :in_journey
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "£#{MAX_BALANCE} limit reached" if @balance >= 90
    @balance += amount
  end

  def touch_in
    raise "Insufficient funds" if @balance < 1
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
