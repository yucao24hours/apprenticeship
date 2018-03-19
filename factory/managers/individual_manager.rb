require "pry"
require "csv"

require_relative "../individual"

class IndividualManager
  CSV_FILE_PATH = "./csv/individual.csv".freeze

  class << self
    def process!
      puts "IndividualManager.process! called"

      CSV.table(CSV_FILE_PATH, header_converters: nil) do |row|
        return nil unless organism

        create_or_update_record_with(row)
      end
    end
  end

  private

  def create_or_update_record_with(row)
    parse(row)
    # 新規作成だったら
    # @organism.individals.create!(name: @name, age: @age, height: @height)
    # みたいな...
    Individual.new(name: @name, age: @age, height: @height)
  end

  def parse(row)
    @idv_id = row["idv_id"]
    @name = row["name"]
    @age = row["age"]
    @height = row["height"]
  end

  def organism
    @organism = Organism.find_by(name: @name)
  end
end
