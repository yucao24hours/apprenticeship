require_relative "./vending_machine.rb"
require_relative "./money.rb"

vending_machine = VendingMachine.new

while true do
  puts "Insert money (enter 0 to refund): "
  amount = gets.chomp.to_i
  break if amount.zero?

  vending_machine.input(Money.new(amount))

  puts "Total: #{vending_machine.summary}"
end

puts "Refund money: #{vending_machine.refund} Yen"
