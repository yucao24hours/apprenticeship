require_relative "./vending_machine.rb"
require_relative "./money.rb"

vending_machine = VendingMachine.new

while true do
  puts "Insert money: "
  amount = gets.chomp.to_i
  vending_machine.input(Money.new(amount))

  puts "Total: #{vending_machine.summary}"
end
