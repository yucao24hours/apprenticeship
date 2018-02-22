require_relative "../../vending_machine.rb"
require_relative "../../money.rb"

RSpec.describe 'VendingMachine', type: :model do
  let(:vending_machine) { VendingMachine.new }

  describe "#input" do
    it "複数回の投入金を受け付けることができ、その総計が取得できること" do
      vending_machine.input(Money.new(100))
      vending_machine.input(Money.new(10))
      vending_machine.input(Money.new(500))

      expect(vending_machine.summary).to eq(610)
    end

    it "それぞれの金種につき 1 個より多く入れようとすると例外になること" do
      money = Money.new(100)
      vending_machine.input(money)
      expect{ vending_machine.input(money) }.to raise_error
    end
  end

  describe "#refund" do
    before do
      vending_machine.input(Money.new(500))
      vending_machine.input(Money.new(100))
      vending_machine.input(Money.new(1000))
    end

    it "投入金額の総計を出力して、投入総計をゼロにする" do
      expect(vending_machine.refund).to eq 1_600
    end
  end
end
