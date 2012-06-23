module Dtest
  class Formatter
    def initialize
      @dtests_messages = []
      @pending_messages = []
    end

    def add_fail_message(message)
      @dtests_messages << message
    end

    def add_pending_message(message)
      @pending_messages << message
    end

    def results(options = {})
      @dtests_messages.flatten.each {|result| puts "\n" + red(result)}
      @pending_messages.flatten.each {|result| puts "\n" + yellow(result)}

      puts "\n\n#{options[:passed] + options[:failed] + options[:pending]} tests ran, #{options[:passed]} passed and #{options[:failed]} failed"
      puts "You have #{options[:pending]} pending" if options[:pending] > 0
    end

    def pass_result(count)
      print green("." * count)
    end

    def fail_result
      print red("f")
    end

    def pending_result
      print yellow("P")
    end    

    def colour_dtest(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
    end

    def red(text); colour_dtest(text, 31); end
    def green(text); colour_dtest(text, 32); end
    def yellow(text); colour_dtest(text, 33); end
  end
end