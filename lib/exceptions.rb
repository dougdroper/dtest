 module Dtest
  class FailException < Exception
    def initialize(expected, actual, msg = "")
      @expected, @actual, @msg =  expected, actual, msg
    end

    def error_message
      @msg << " Expected #{@expected} but got #{@actual} "
    end
  end

  class PendingExcepttion < Exception; end
end