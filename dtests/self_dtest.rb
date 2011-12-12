require 'lib/assertions'

class DtestClass < Dtest::Assertions
  dtest "should pass" do
    assert(true, true)
  end

  dtest "counts the test twice" do
    assert(true, true)
    assert_not(false, true)
  end

  dtest "should fail" do
    assert(true, false)
  end

  dtest "fails with a message" do
    assert(true, false, "with a message") 
  end

  dtest "passes with opposites" do
    assert_not(false, true) 
  end

  dtest "fails with opposites" do
    assert_not(true, true) 
  end
  
  dtest "pending" do
    pending
    puts "This should not get run"
    assert(true, true)
  end

  dtest "is also pending"

end
