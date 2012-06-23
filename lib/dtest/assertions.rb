require_relative 'stubs'

module Dtest
  class Assertions 
    include Stubs
    
    attr_reader :count, :dtests_messages

    def initialize
      @count = 0
      @dtests_messages = []
    end

    def self.dtest(name, &block)
      test_name = "dtest_#{name.gsub(/\s+/, '_')}"
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          raise PendingExcepttion.new
        end
      end
    end

    def self.inherited(klass)
      @tests ||= [] << klass
    end

    def self.get_tests
      @tests ||= []
    end

    def assert(expected, actual, fail_message=nil)
      @count += 1
      raise FailException.new(expected, actual, fail_message || "assert") unless expected == actual
    end

    def assert_not(expected, actual, fail_message=nil)
      @count += 1
      raise FailException.new(expected, actual, fail_message || "assert_not") if expected == actual
    end

    def pending
      raise PendingExcepttion.new
    end
  end
end