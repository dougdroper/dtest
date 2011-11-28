require 'lib/exceptions'

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