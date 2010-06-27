$LOAD_PATH.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end
require 'httparty'

module Mousetrap
  
  class Error < StandardError; end
  
  class ResponseError < Error
    attr_reader :id, :code, :aux_code
    def initialize(msg, opts = {})
      super msg
      @id = opts['id'] if opts['id']
      @code = opts['code'] if opts['code']
      @aux_code = opts['auxCode'] if opts['auxCode']
    end
  end
  
  class PreconditionFailedError < ResponseError
    attr_reader :field, :failure
    
    def initialize(msg, opts = {})
      super
      @field, @failure = @aux_code.split(':')
    end
    
    def to_s 
      "#{super}. (#{@aux_code})" 
    end
  end
  
  class UnprocessableEntityError < ResponseError
    def initialize(msg, opts = {})
      super
    end
  end
  
  class ApiNotSupported < NotImplementedError
    def initialize
      super "CheddarGetter API doesn't support this."
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
