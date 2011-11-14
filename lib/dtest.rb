module Dtest
  class Assertions
    def assert(expected, actual)
      if expected == actual
        puts "."
      else
        puts "f"
      end
    end
  end


  class Able
    def initialize(file)
      # do somethings with files
    end
  end
end