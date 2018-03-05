require_relative "./drink"

class VendingMachine
  ACCEPTABLE_MONEY = [10, 50, 100, 500, 1_000]

  attr_reader :summary, :amount

  def initialize
    @stocks = []
    5.times do
      add_stock(Drink.new(name: "コーラ", price: 120))
    end

    @summary = 0
  end

  def grouped_stocks

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
    # ここで @stocks にはハッシュ形式で個数を取得できたほうが便利そう
    # {'cola' => 3, 'orange_juice' => 12}
    # と思ったが、そうなると、Drink のオブジェクトは格納する必要がなくなる？？？？
    # でも値段とかは保持してないとだめだと思うので,,,。
    # => Drink オブジェクトをキーにするといいかもしれない。
    # cola = Drink.new(name: 'cola', price: 120)
    # {cola => 3}
    (@summary >= drink.price) && (@stocks.select{|stock| stock.name == drink.name }.count > 0)
  end

  def add_stock(drink)
    @stocks << drink
  end
end
