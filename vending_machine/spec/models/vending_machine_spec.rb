require_relative "../../vending_machine.rb"

RSpec.describe 'VendingMachine', type: :model do
  let(:vending_machine) do
    drinks = []
    5.times do
      drinks << Drink.new(name: "コーラ", price: 120)
    end
    VendingMachine.new(drinks)
  end

  describe "#grouped_stocks" do
    it "商品の種類ごとに個数が取得できる" do
      expect(vending_machine.grouped_stocks['コーラ'].count).to eq 5

      drink = Drink.new(name: "オレンジジュース", price: 150)
      vending_machine.add_stock(drink)

      expect(vending_machine.grouped_stocks['オレンジジュース'].count).to eq 1
    end
  end

  describe "#add_stock" do
    it "在庫を追加できる" do
      expect(vending_machine.stocks.count).to eq 5

      drink = Drink.new(name: "コーラ", price: 120)
      vending_machine.add_stock(drink)
      vending_machine.add_stock(drink)
      vending_machine.add_stock(drink)

      expect(vending_machine.stocks.count).to eq 8
    end
  end

  describe "#input" do
    context "受付可能な金種を投入されたとき" do
      it "複数回の投入金を受け付けることができ、その総計が取得できること" do
        vending_machine.input(100)
        vending_machine.input(10)
        vending_machine.input(500)
        vending_machine.input(1_000)

        expect(vending_machine.summary).to eq(1_610)
      end
    end

    context "受付できない金種を投入されたとき" do
      it "投入総計には加算しないこと" do
        vending_machine.input(1)
        vending_machine.input(5)
        vending_machine.input(5_000)
        vending_machine.input(10_000)
        vending_machine.input(10)
        expect(vending_machine.summary).to eq(10)
      end

      it "投入された金額をそのまま返すこと" do
        expect(vending_machine.input(5)).to eq 5
      end
    end
  end

  describe "#refund" do
    before do
      vending_machine.input(500)
      vending_machine.input(100)
      vending_machine.input(1000)
    end

    context "飲み物の購入前" do
      it "現在の投入金額を出力して、投入総計をゼロにする" do
        expect(vending_machine.refund).to eq 1_600

        expect(vending_machine.summary).to eq 0
      end
    end

    context "飲み物の購入後" do
      it "現在の投入金額からジュース購入金額を引いた釣り銭を出力して、投入総計をゼロにする" do
        drink = Drink.new(name: "コーラ", price: 120)
        vending_machine.sell(drink)

        expect(vending_machine.refund).to eq 1_480
        expect(vending_machine.summary).to eq 0
      end

      it "複数回購入しても、現在の投入金額からジュース購入金額を引いた釣り銭を出力して、投入総計をゼロにする" do
        drink = Drink.new(name: "コーラ", price: 120)
        vending_machine.sell(drink)
        vending_machine.sell(drink)

        expect(vending_machine.refund).to eq 1_360
        expect(vending_machine.summary).to eq 0
      end
    end
  end

  describe "#can_buy?" do
    it "任意ののみものを購入するのに、在庫・投入金額が十分な場合は true を返す" do
      vending_machine.input(100)
      vending_machine.input(10)
      vending_machine.input(10)

      cola = Drink.new(name: "コーラ", price: 120)
      expect(vending_machine.can_buy?(cola)).to be true
    end

    it "任意ののみものを購入するのに、在庫は十分だが投入金額が不十分な場合は false を返す" do
      cola = Drink.new(name: "コーラ", price: 120)

      vending_machine.input(100)
      vending_machine.input(10)

      expect(vending_machine.can_buy?(cola)).to be false
    end

    # it "任意ののみものを購入するのに、投入金額は十分だが在庫が不十分な場合は false を返す" do
    #   cola = Drink.new(name: "コーラ", price: 120)
    #   # vending_machine.add_stock(drink) とか
    #   # vending_machine.reduce_stock(drink, number) とか外からやれるようにしたほうがいいのかなー
    #   # add のほうは、initialize からロジックを剥がすのに使えそうだけど、reduce のほうは完全に実装都合な気もする。。
    #   # しかしそういうとき、このケースのテストはどう書くといいのだろうか

    #   vending_machine.input(100)
    #   vending_machine.input(10)
    #   vending_machine.input(10)

    #   expect(vending_machine.can_buy?(cola)).to be false
    # end
  end

  describe "#sell" do
    let!(:drink) { Drink.new(name: "コーラ", price: 120) }

    before do
      vending_machine.input(1000)
    end

    it "在庫を減らし、売上金額を減らす" do
      expect(vending_machine.grouped_stocks['コーラ'].count).to eq 5
      expect(vending_machine.amount).to eq 0

      vending_machine.sell(drink)

      expect(vending_machine.grouped_stocks['コーラ'].count).to eq 4
      expect(vending_machine.amount).to eq 120
    end
  end
end
