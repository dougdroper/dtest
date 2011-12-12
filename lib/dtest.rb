require 'lib/assertions'
require 'lib/exceptions'
require 'lib/formatter'

module Dtest
  class Able
    def initialize(directory)
      @passed = 0
      @failed = 0
      @pending = 0
      @formatter = Formatter.new
      start_dtests(directory)
    end

    private

    def require_dtest_files(directory)
      Dir["#{directory}/*"].each do |file|
        next unless ! file == '.' || ! file == '..' || file =~ /dtest/
        if File.directory?(file)
          require_dtest_files(file)
        else 
          require file
        end
      end
    end

    def start_dtests(directory)
      require_dtest_files(directory)
      run_dtests
      print_dtests_results
    end

    def run_dtests
      Assertions.get_tests.each do |klass|
        klass.instance_methods.select{|m| m =~ /dtest/ }.each do |m|
          assertion = klass.new
          begin
            assertion.send(m)
            @formatter.pass_result(assertion.count)
            @passed += assertion.count 
          rescue FailException => e
            @formatter.fail_result
            @formatter.add_fail_message(e.error_message + "\n\n#{klass}, \##{m} \n" + e.backtrace[1].to_s)
            @failed += 1
          rescue PendingExcepttion => e
            @formatter.pending_result
            @pending += 1
            @formatter.add_pending_message("\n PENDING #{klass}, \##{m}")
          end
          STDOUT.flush
          # sleep(0.5)
          @formatter.add_fail_message(assertion.dtests_messages)
        end
      end
    end

    def print_dtests_results
      @formatter.results({:passed => @passed, :failed => @failed, :pending => @pending})
    end
  end
end
