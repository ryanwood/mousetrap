module Mousetrap
  class Customer < Resource
    attr_accessor \
      :id,
      :code,
      :email,
      :first_name,
      :last_name,
      :company,
      :subscription

    def update_tracked_item_quantity(item_code, quantity = 1)
      tracked_item_resource = if quantity == quantity.abs
        'add-item-quantity'
      else
        'remove-item-quantity'
      end

      attributes = {
        :itemCode => item_code,
        :quantity => quantity.abs
      }

      response = self.class.put_resource 'customers', tracked_item_resource, code, attributes
      raise response['error'] if response['error']
      response
    end

    def add_item_quantity(item_code, quantity = 1)
      update_tracked_item_quantity(item_code, quantity)
    end

    def remove_item_quantity(item, quantity = 1)
      update_tracked_item_quantity(item_code, -quantity)
    end

    def add_custom_charge(item_code, amount = 1.0, quantity = 1, description = nil)
      attributes = {
        :chargeCode  => item_code,
        :eachAmount  => amount,
        :quantity    => quantity,
        :description => description
      }

      response = self.class.put_resource 'customers', 'add-charge', code, attributes
      raise response['error'] if response['error']
      response
    end

    def subscription_attributes=(attributes)
      self.subscription = Subscription.new attributes
    end

    def attributes
      {
        :id         => id,
        :code       => code,
        :email      => email,
        :first_name => first_name,
        :last_name  => last_name,
        :company    => company
      }
    end

    def attributes_for_api
      # TODO: superclass?
      self.class.attributes_for_api(attributes, new_record?)
    end

    def attributes_for_api_with_subscription
      raise "Must have subscription" unless subscription
      a = attributes_for_api
      a[:subscription] = subscription.attributes_for_api
      a
    end

    def cancel
      member_action 'cancel' unless new_record?
    end

    def new?
      if api_customer = self.class[code]
        self.id = api_customer.id

        return false
      else
        return true
      end
    end

    def save
      new? ? create : update
    end

    def switch_to_plan(plan_code)
      raise "Can only call this on an existing CheddarGetter customer." unless exists?

      attributes = { :planCode => plan_code }
      self.class.put_resource('customers', 'edit-subscription', code, attributes)

      # TODO: Refresh self with reload here?
    end

    def self.all
      response = get_resources 'customers'

      if response['error']
        if response['error'] =~ /No customers found/
          return []
        else
          raise response['error']
        end
      end

      build_resources_from response
    end

    def self.create(attributes)
      object = new(attributes)
      object.send(:create)
      object
    end

    def self.new_from_api(attributes)
      customer = new(attributes_from_api(attributes))
      subscription_attrs = attributes['subscriptions']['subscription']
      customer.subscription = Subscription.new_from_api(subscription_attrs.kind_of?(Array) ? subscription_attrs.first : subscription_attrs)
      customer
    end

    def self.update(customer_code, attributes)
      customer = new(attributes)
      customer.code = customer_code
      customer.send :update
    end


    protected

    def self.plural_resource_name
      'customers'
    end

    def self.singular_resource_name
      'customer'
    end

    def self.attributes_for_api(attributes, new_record = true)
      mutated_hash = {
        :email     => attributes[:email],
        :firstName => attributes[:first_name],
        :lastName  => attributes[:last_name],
        :company   => attributes[:company]
      }
      mutated_hash.merge!(:code => attributes[:code]) if new_record
      mutated_hash
    end

    def self.attributes_from_api(attributes)
      {
        :id         => attributes['id'],
        :code       => attributes['code'],
        :first_name => attributes['firstName'],
        :last_name  => attributes['lastName'],
        :company    => attributes['company'],
        :email      => attributes['email']
      }
    end

    def create
      response = self.class.post_resource 'customers', 'new', attributes_for_api_with_subscription

      raise response['error'] if response['error']

      returned_customer = self.class.build_resource_from response
      self.id = returned_customer.id
      response
    end

    def update
      if subscription
        response = self.class.put_resource 'customers', 'edit', code, attributes_for_api_with_subscription
      else
        response = self.class.put_resource 'customers', 'edit-customer', code, attributes_for_api
      end

      raise response['error'] if response['error']
    end
  end
end
