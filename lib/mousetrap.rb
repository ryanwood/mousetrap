$LOAD_PATH.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end
require 'httparty'

module Mousetrap
  
  class Error < StandardError; end
  class ApiNotSupported < NotImplementedError
    def initialize
      super("CheddarGetter API doesn't support this.")
    end
  end

  autoload :Customer,     'mousetrap/customer'
  autoload :Plan,         'mousetrap/plan'
  autoload :Resource,     'mousetrap/resource'
  autoload :Subscription, 'mousetrap/subscription'

  class << self
    attr_accessor :product_code

    def authenticate(user, password)
      Resource.basic_auth user, password
    end
  end
end
