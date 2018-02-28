class VendingMachine
  attr_reader :summary

  def initialize
    @summary = 0
  end

  def input(amount)
    @summary += amount
  end

  def refund
    summary = @summary
    @summary = 0

    summary
  end
end
