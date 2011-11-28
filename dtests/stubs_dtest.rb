require 'lib/assertions'

class User; end

class DtestClass < Dtest::Assertions
  def it_stubs_dtest  
    user = User.new
    Dtest::Stubs.stubs(:logged_in?, :for => user, :returns => true)
    assert(user.logged_in?, true)
  end

  def it_stubs_dtest_with_words
    user = User.new
    Dtest::Stubs.stubs(:logged_in?, :for => user, :returns => "Yes he is")
    assert(user.logged_in?, "Yes he is")
  end
end

