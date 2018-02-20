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
end
