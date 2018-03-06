require_relative "./drink"

class VendingMachine
  ACCEPTABLE_MONEY = [10, 50, 100, 500, 1_000]

  attr_reader :summary, :stocks, :amount

  def initialize
    @stocks = []
    5.times do
      add_stock(Drink.new(name: "コーラ", price: 120))
    end

    @summary = 0
  end

  def grouped_stocks
    @stocks.group_by{|item| item.name }
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

  def can_buy?(drink)
    (@summary >= drink.price) && (grouped_stocks[drink.name].count > 0)
  end

  def add_stock(drink)
    @stocks << drink
  end
end
