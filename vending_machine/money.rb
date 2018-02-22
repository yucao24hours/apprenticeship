class Money
  ACCEPTABLE_AMOUNT = [10, 50, 100, 500, 1_000]

  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  class << self
    def acceptable_amount?(amount)
      ACCEPTABLE_AMOUNT.include?(amount)
    end
  end
end
