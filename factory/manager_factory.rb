require "pry"
require_relative "./organism"
require_relative "./individual"

class ManagerFactory
  class << self
    def create_manager(klass_name)
      case klass_name
      when :organism
        OrganismManager.new
      when :Individual
        IndividualManager.new
      end
    end
  end
end
