module Dtest
  module Stubs
    extend self
    def stubs(method, options={})
      singleton(options[:for]).send(:define_method, method) do |*a|
        options[:returns]
      end
    end
    def singleton(obj)
      class << obj; self; end
    end
  end
end

