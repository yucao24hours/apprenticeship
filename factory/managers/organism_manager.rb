require "pry"
require "csv"
require_relative "../organism"

class OrganismManager
  CSV_FILE_PATH = "./csv/organism.csv".freeze

  class << self
    def process!
      puts "OrganismManager.process! called"
        CSV.table(CSV_FILE_PATH, header_converters: nil) do |row|
      end
    end
  end
end
