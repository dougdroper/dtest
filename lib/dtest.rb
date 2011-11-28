require 'lib/assertions'
require 'lib/exceptions'

module Dtest
  class Able
    def initialize(directory)
      @dtests_messages = []
      @pending_messages = []
      @passed = 0
      @failed = 0
      @pending = 0
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
      Assertions.get_tests.each do |klass|
        klass.instance_methods.select{|m| m =~ /_dtest/ }.each do |m|
          assertion = klass.new
          begin
            assertion.send(m)
            print green("." * assertion.count)
            @passed += assertion.count 
          rescue FailException => e
            print red "f"
            @failed += 1
            @dtests_messages << [
              e.error_message + 
              "\n\n#{klass}, \##{m} \n" +
              e.backtrace[1].to_s
            ]
          rescue PendingExcepttion => e
            print yellow "P"
            @pending += 1
            @pending_messages << ["\n PENDING #{klass}, \##{m}"]
          end
          @dtests_messages << assertion.dtests_messages
        end
      end
    end

    def colour_dtest(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
    end

    def red(text); colour_dtest(text, 31); end
    def green(text); colour_dtest(text, 32); end
    def yellow(text); colour_dtest(text, 33); end

    def print_dtests_results
      @dtests_messages.flatten!.each {|result| puts "\n" + red(result)}
      @pending_messages.flatten!.each {|result| puts "\n" + yellow(result)}

      puts "\n\n#{@passed + @failed + @pending} tests ran, #{@passed} passed and #{@failed} failed"
      puts "You have #{@pending} pending" if @pending > 0
    end
  end
end
