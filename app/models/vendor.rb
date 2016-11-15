class Vendor
#class Vendor < ActiveRecord::Base


    # TODO:  remove when Vendor becomes an ActiveRecord
    include ActiveModel::Model


    attr_accessor :display_name

    # TODO: enable when Vendor becomes an ActiveRecord
#    after_find :set_display_name


    attr_accessor   :name
    attr_accessor   :address1
    attr_accessor   :address2
    attr_accessor   :city
    attr_accessor   :state
    attr_accessor   :postal_code
    attr_accessor   :phone
    attr_accessor   :fax
    attr_accessor   :pharmacy_account_number
    attr_accessor   :last_order_date
    attr_accessor   :login_name
    attr_accessor   :website
    attr_accessor   :allow_narcotics
    attr_accessor   :allow_controlled
    attr_accessor   :order_by_number
    attr_accessor   :retain_backorders
    attr_accessor   :x12_interface
    attr_accessor   :purchase_order_format
    attr_accessor   :credit_limit
    attr_accessor   :purchase_order_type


    def set_display_name

        # TODO:  remove when Vendor becomes an ActiveRecord
        self.display_name = "Test Vendor"
        # TODO: enable when Vendor becomes an ActiveRecord
#		self.display_name = self.name
	end

end
