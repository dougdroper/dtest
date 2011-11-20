module Dtest
  class Assertions
    def self.inherited(klass)
      @tests ||= [] << klass
    end

    def self.get_tests
      @tests
    end

    def assert(expected, actual)
      if expected == actual
        puts "."
      else
        puts "f"
      end
    end
  end

  class Able
    def initialize(directory)
      Dir["#{directory}/*"].each do |file|
        next unless ! file == '.' || ! file == '..' || file =~ /dtest/
        require file
      end
      run_tests
    end

    def run_tests
      Dtest::Assertions.get_tests.each do |klass|
        instance = klass.new
        meths = klass.instance_methods.select{|m| m =~ /_test/ }
        meths.each{|m| instance.send(m) }
      end
    end
  end
end