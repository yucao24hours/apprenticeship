class VendingMachine
  MAX_INSERTION = {
    10   => 1,
    50   => 1,
    100  => 1,
    500  => 1,
    1000 => 1
  }.freeze

  attr_reader :summary

  def initialize
    @summary = 0
    @insertion_count = {
      10   => 0,
      50   => 0,
      100  => 0,
      500  => 0,
      1000 => 0
    }
  end

  def input(money)
    raise if reach_max_insertion?(money.amount)

    @summary = @summary + money.amount
    @insertion_count[money.amount] += 1
  end

  private

  def reach_max_insertion?(amount)
    MAX_INSERTION[amount] == @insertion_count[amount]
  end
end
