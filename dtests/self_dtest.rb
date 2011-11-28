require 'lib/assertions'

class DtestClass < Dtest::Assertions
  def it_passes_dtest
    assert(true, true)
  end

  def it_counts_dtest_twice
    assert(true, true)
    assert_not(false, true)
  end

  def it_fails_dtest
    assert(true, false) 
  end

  def it_fails_dtest_with_a_message
    assert(true, false, "with a message") 
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

  def its_pending_dtest
    pending
    puts "This should not get run"
    assert(true, true)
  end
end
