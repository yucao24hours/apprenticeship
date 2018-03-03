require_relative "../../vending_machine.rb"

RSpec.describe 'VendingMachine', type: :model do
  let(:vending_machine) { VendingMachine.new }

  describe "#input" do
    it "初期状態で、コーラ（120円/本）を 5 本格納している" do
      expect(vending_machine.stocks.count).to eq 5

      expect(vending_machine.stocks[0].name).to  eq "コーラ"
      expect(vending_machine.stocks[0].price).to eq 120

      expect(vending_machine.stocks[1].name).to  eq "コーラ"
      expect(vending_machine.stocks[1].price).to eq 120

      expect(vending_machine.stocks[2].name).to  eq "コーラ"
      expect(vending_machine.stocks[2].price).to eq 120

      expect(vending_machine.stocks[3].name).to  eq "コーラ"
      expect(vending_machine.stocks[3].price).to eq 120

      expect(vending_machine.stocks[4].name).to  eq "コーラ"
      expect(vending_machine.stocks[4].price).to eq 120
    end

    context "受付可能な金種を投入されたとき" do
      it "複数回の投入金を受け付けることができ、その総計が取得できること" do
        vending_machine.input(100)
        vending_machine.input(10)
        vending_machine.input(500)
        vending_machine.input(10)

        expect(vending_machine.summary).to eq(620)
      end
    end

    context "受付できない金種を投入されたとき" do
      it "投入総計には加算しないこと" do
        vending_machine.input(1)
        vending_machine.input(10)
        expect(vending_machine.summary).to eq(10)
      end
    end
  end

  describe "#refund" do
    before do
      vending_machine.input(500)
      vending_machine.input(100)
      vending_machine.input(1000)
    end

    it "投入金額の総計を出力して、投入総計をゼロにする" do
      expect(vending_machine.refund).to eq 1_600

      expect(vending_machine.summary).to eq 0
    end
  end

  describe "#return_change" do
    it "投入された金額をそのまま返すこと" do
      expect(vending_machine.return_change(5)).to eq 5
    end
  end

  describe "#can_buy?", focus: true do

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
end
