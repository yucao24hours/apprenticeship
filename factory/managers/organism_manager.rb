require "pry"
require "csv"
require_relative "../organism"

class OrganismManager
  CSV_FILE_PATH = "./csv/organism.csv".freeze

  class << self
    def process!
      puts "OrganismManager.process! called"

      CSV.table(CSV_FILE_PATH, header_converters: nil) do |row|
        puts row
        hoge = Organism.new(name: row["name"], height: row["height"], age: row["age"])
      end
    end
  end
end
