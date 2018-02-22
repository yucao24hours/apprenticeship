require_relative "../../vending_machine.rb"
require_relative "../../money.rb"

RSpec.describe "Money", type: :model do
  let(:vending_machine) { VendingMachine.new }

  describe ".acceptable_amount?" do
    it "金種として適切な金額の場合は true を返すこと" do
      expect(Money.acceptable_amount?(10)).to be true
      expect(Money.acceptable_amount?(50)).to be true
      expect(Money.acceptable_amount?(100)).to be true
      expect(Money.acceptable_amount?(500)).to be true
      expect(Money.acceptable_amount?(1_000)).to be true
    end

    it "金種として適切な金額でない場合は false を返すこと" do
      expect(Money.acceptable_amount?(1)).to be false
      expect(Money.acceptable_amount?(5)).to be false
      expect(Money.acceptable_amount?(5_000)).to be false
      expect(Money.acceptable_amount?(10_000)).to be false
    end
  end
end
