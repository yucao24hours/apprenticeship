require_relative "../../vending_machine.rb"

RSpec.describe 'VendingMachine', type: :model do
  let(:vending_machine) { VendingMachine.new }

  describe "#input" do
    context "受付可能な金種を投入されたとき" do
      it "複数回の投入金を受け付けることができ、その総計が取得できること" do
        vending_machine.input(100)
        vending_machine.input(10)
        vending_machine.input(500)
        vending_machine.input(10)

        expect(vending_machine.summary).to eq(620)
      end
    end

      it "想定外の金種を投入されたら、投入総計には加算しないこと" do
    context "受付できない金種を投入されたとき" do
        vending_machine.input(1)
        expect(vending_machine.summary).to eq(0)

        vending_machine.input(5)
        expect(vending_machine.summary).to eq(0)

        vending_machine.input(10_000)
        expect(vending_machine.summary).to eq(0)
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
end
