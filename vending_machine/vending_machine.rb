require_relative "./drink"

class VendingMachine
  ACCEPTABLE_MONEY = [10, 50, 100, 500, 1_000]

  attr_reader :summary, :stocks

  def initialize
    colas = []
    5.times do
      colas << Drink.new(name: "コーラ", price: 120)
    end

    @stocks = colas
    @summary = 0
  end

  def input(money)
    return_change(money) and return unless ACCEPTABLE_MONEY.include?(money)

    @summary += money
  end

  def refund
    summary = @summary
    @summary = 0

    summary
  end

  def return_change(money)
    return money
  end
end
