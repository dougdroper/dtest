module Dtest
  class Assertions
    def self.inherited(klass)
      @tests ||= [] << klass
    end

    def self.get_tests
      @tests ||= []
    end

    def assert(expected, actual)
      expected == actual ? "." : "f"
    end

    def assert_not(expected, actual)
      expected == actual ? "f" : "."
    end

    def pending
      "p"
    end
  end

  class Able
    def initialize(directory)
      require_files(directory)
      @count_dtests = 0
      @dtests = []
      run_dtests
    end

    private

    def require_files(directory)
      Dir["#{directory}/*"].each do |file|
        next unless ! file == '.' || ! file == '..' || file =~ /dtest/
        require file
      end
    end

    def run_dtests
      Dtest::Assertions.get_tests.each do |klass|
        klass.instance_methods.select{|m| m =~ /_dtest/ }.each do |m|
          @count_dtests += 1 
          @dtests << klass.new.send(m)
        end
      end
      print_dtests_results
    end

    def print_dtests_results
      passed = @dtests.select {|r| r == "."}.count
      failed = @dtests.select {|r| r == "f"}.count
      pending = @dtests.select {|r| r == "p"}.count

      @dtests.each {|result| print result}
      puts
      puts
      puts "#{@count_dtests} tests ran, #{passed} passed and #{failed} failed"
      puts "You have #{pending} pending" if pending > 0
    end
  end
end
