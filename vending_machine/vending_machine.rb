require_relative "./drink"

class VendingMachine
  ACCEPTABLE_MONEY = [10, 50, 100, 500, 1_000]

  # amount: 売上
  # summary: 投入合計金額
  # stocks: 在庫一覧
  attr_reader :summary, :stocks, :amount

  def initialize(drinks)
    @stocks = []

    drinks.each do |drink|
      add_stock(drink)
    end

    # 売上累計金額
    @amount = 0
    # 投入累計金額
    @summary = 0
  end

  def grouped_stocks
    @stocks.group_by{|item| item.name }
  end

  def input(money)
    if ACCEPTABLE_MONEY.include?(money)
      @summary += money
    else
      return_change(money)
    end
  end

  def refund
    summary = @summary
    @summary = 0

    summary
  end

  def can_buy?(drink)
    (@summary >= drink.price) && (grouped_stocks[drink.name].count > 0)
  end

  def add_stock(drink)
    @stocks << drink
  end

  def sell(drink)
    # XXX 二段階で処理してるのでなんか微妙だけど、いい方法が他にあるのだろうか
    # XXX 在庫がなかったときの処理はまだ書いていない
    if can_buy?(drink)
      index = @stocks.find_index{|stock| stock.name == drink.name }
      sold = @stocks.delete_at(index)
      @amount += sold.price
      @summary -= sold.price
    end
  end

  private

  def return_change(money)
    return money
  end
end
