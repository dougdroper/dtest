module Dtest
  class Assertions
    attr_reader :count, :dtests_messages

    def initialize
      @count = 0
      @dtests_messages = []
    end

    def self.inherited(klass)
      @tests ||= [] << klass
    end

    def self.get_tests
      @tests ||= []
    end

    def assert(expected, actual)
      @count += 1
      msg = expected == actual ? "." : "f"
      @dtests_messages << msg
    end

    def assert_not(expected, actual)
      @count += 1
      msg = expected == actual ? "f" : "."
      @dtests_messages << msg
    end

    def pending
      "p"
    end
  end

  class Able
    def initialize(directory)
      @count_dtests = 0
      @dtests_messages = []
      start_dtests(directory)
    end

    private

    def require_dtest_files(directory)
      Dir["#{directory}/*"].each do |file|
        next unless ! file == '.' || ! file == '..' || file =~ /dtest/
        require file
      end
    end

    def start_dtests(directory)
      require_dtest_files(directory)
      run_dtests
      print_dtests_results
    end

    def run_dtests
      Dtest::Assertions.get_tests.each do |klass|
        klass.instance_methods.select{|m| m =~ /_dtest/ }.each do |m|
          assertion = klass.new
          assertion.send(m)
          @count_dtests += assertion.count
          @dtests_messages << assertion.dtests_messages
        end
      end
    end

    def print_dtests_results
      passed = @dtests_messages.flatten.select {|r| r == "."}.count
      failed = @dtests_messages.flatten.select {|r| r == "f"}.count
      pending = @dtests_messages.flatten.select {|r| r == "p"}.count

      @dtests_messages.each {|result| print result}
      puts
      puts
      puts "#{@count_dtests} tests ran, #{passed} passed and #{failed} failed"
      puts "You have #{pending} pending" if pending > 0
    end
  end
end
