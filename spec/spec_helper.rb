$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mousetrap'
require 'spec'
require 'spec/autorun'
require 'factory_girl'
require 'active_support'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

module Mousetrap
  class Resource
    def self.get(*args)
      raise 'You must stub this, or should_receive at a higher level.'
    end

    def self.post(*args)
      raise 'You must stub this, or should_receive at a higher level.'
    end
  end
end

# This simulates the strange behavior of crack (used by httparty)
# when it populates a text node that has attributes in the 
# resulting XML.
# 
# A CheddarGetter error XML is as follows:
#
#   <error id="1234" code="404" auxCode="">Customer not found</error>
#
# The parsed result will look like this:
#
#   { "error" => "Customer not found" }
#
# To get the attributes for that node, you can call #attributes
# directly on the key:
# 
#   result = { "error" => "Customer not found" }
#   result["error"].attributes  # => { "id" => "1234", "code" => "404", "auxCode" = "" }
# 
# For more details see this test: 
# http://github.com/jnunemaker/crack/blob/master/test/xml_test.rb
#
def response_error_hash(text, attributes = {})
  node_with_attributes = text
  node_with_attributes.stub! :attributes => { 'id' => '12345', 'code' => '500', 'auxCode' => '5000' }.merge(attributes)
  { 'error' => node_with_attributes }
end