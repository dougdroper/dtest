require File.join(File.dirname(__FILE__), '../lib', 'dtest')

class TestClass < Dtest::Assertions
  def it_passes
    assert(true, true) 
  end
end

Dir.foreach('dtests') do |file|
  next unless ! file == '.' || ! file == '..' || file =~ /dtest/
  Dtest::Able.new(file)
end