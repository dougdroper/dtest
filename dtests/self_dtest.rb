require File.join(File.dirname(__FILE__), '../lib', 'dtest')

class TestClass < Dtest::Assertions
  def it_passes_test
    assert(true, true) 
  end
end

Dtest::Able.new("dtests")