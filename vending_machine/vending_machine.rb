class VendingMachine
  attr_reader :summary

  def initialize
    @summary = 0
  end

  def input(money)
    @summary = @summary + money.amount
  end
end
