require 'lib/assertions'

class User; end

class DtestClass < Dtest::Assertions
  dtest "stubs" do
    user = User.new
    Dtest::Stubs.stubs(:logged_in?, :for => user, :returns => true)
    assert(user.logged_in?, true)
  end

  dtest "stubs with a message" do
    user = User.new
    Dtest::Stubs.stubs(:logged_in?, :for => user, :returns => "Yes he is")
    assert(user.logged_in?, "Yes he is")
  end
end

