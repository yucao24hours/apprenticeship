require_relative "../../vending_machine.rb"

RSpec.describe 'VendingMachine', type: :model do
  let(:vending_machine) do
    drinks = []
    5.times do
      drinks << Drink.new(name: "コーラ", price: 120)
    end
    VendingMachine.new(drinks)
  end

  describe "#stocks_find_by_name" do
    it "指定された商品の個数が取得できる" do
      expect(vending_machine.stocks_find_by_name('コーラ').count).to eq 5

      drink = Drink.new(name: "オレンジジュース", price: 150)
      vending_machine.add_stock([drink])

      expect(vending_machine.stocks_find_by_name('オレンジジュース').count).to eq 1
    end
  end

  describe "#add_stock" do
    describe "在庫の追加" do
      context "ひとつの種類の飲み物" do
        it "在庫を追加できる" do
          expect(vending_machine.stocks.count).to eq 5

          drinks = []
          3.times do
            drinks << Drink.new(name: "コーラ", price: 120)
          end
          vending_machine.add_stock(drinks)

          expect(vending_machine.stocks.count).to eq 8
        end
      end

      context "複数の種類の飲み物" do
        it "在庫を追加できる" do
        end
      end
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
        vending_machine.sell(drink.name)

        expect(vending_machine.refund).to eq 1_480
        expect(vending_machine.summary).to eq 0
      end

      it "複数回購入しても、現在の投入金額からジュース購入金額を引いた釣り銭を出力して、投入総計をゼロにする" do
        drink = Drink.new(name: "コーラ", price: 120)
        vending_machine.sell(drink.name)
        vending_machine.sell(drink.name)

        expect(vending_machine.refund).to eq 1_360
        expect(vending_machine.summary).to eq 0
      end
    end
  end

  describe "#sell" do
    context "購入したい商品に対し、在庫も投入金額も十分な場合" do
      let!(:drink) { Drink.new(name: "コーラ", price: 120) }

      before do
        vending_machine.input(1000)
      end

      it "在庫を減らし、売上金額を減らす" do
        expect(vending_machine.stocks_find_by_name("コーラ").count).to eq 5
        expect(vending_machine.amount).to eq 0

        vending_machine.sell("コーラ")

        expect(vending_machine.stocks_find_by_name("コーラ").count).to eq 4
        expect(vending_machine.amount).to eq 120
      end
    end

    context "購入したい商品に対し、条件が不十分な場合" do
      let!(:cola) { Drink.new(name: "コーラ", price: 120) }
      let!(:orange_juice) { Drink.new(name: "オレンジジュース", price: 150) }

      context "在庫は十分だが、投入金額が不十分な場合" do
        before do
          vending_machine.input(100)
        end

        it "在庫数も売上金額も変化しない" do
          expect(vending_machine.stocks_find_by_name("コーラ").count).to eq 5
          expect(vending_machine.amount).to eq 0

          expect(vending_machine.sell("コーラ")).to be nil

          expect(vending_machine.stocks_find_by_name("コーラ").count).to eq 5
          expect(vending_machine.amount).to eq 0
        end
      end

      context "投入金額は十分だが、在庫が不十分な場合" do
        before do
          vending_machine.input(1_000)
        end

        it "在庫数も売上金額も変化しない" do
          expect(vending_machine.stocks_find_by_name("オレンジジュース").count).to eq 0
          expect(vending_machine.amount).to eq 0

          expect(vending_machine.sell(orange_juice.name)).to be nil

          expect(vending_machine.stocks_find_by_name("オレンジジュース").count).to eq 0
          expect(vending_machine.amount).to eq 0
        end
      end
    end
  end
end
