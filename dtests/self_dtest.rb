require File.join(File.dirname(__FILE__), '../lib', 'dtest')

class DtestClass < Dtest::Assertions
  def it_passes_dtest
    assert(true, true) 
  end

  def it_fails_dtest
    assert(true, false) 
  end

  def it_fails_dtest_too
    assert(false, true) 
  end

  def it_passes_dtest_opposite
    assert_not(false, true) 
  end

  def it_fails_dtest_opposite
    assert_not(true, true) 
  end

  def it_pending_dtest
    assert(false, true) 
    pending
  end
end
