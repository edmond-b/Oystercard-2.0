class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "£#{MAX_BALANCE} limit reached" if @balance >= 90
    @balance += amount
  end
end
