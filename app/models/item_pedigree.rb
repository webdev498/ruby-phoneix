class ItemPedigree < ActiveRecord::Base

    # TODO:  remove when ItemPedigree becomes an ActiveRecord
    include ActiveModel::Model

    belongs_to :item

    attr_accessor :display_name

    # TODO: enable when ItemPedigree becomes an ActiveRecord
#    after_find :set_display_name


    attr_accessor   :lot_number
    attr_accessor   :serial_number
    attr_accessor   :vendor
    attr_accessor   :date_received
    attr_accessor   :quantity_received
    attr_accessor   :quantity_remaining


    # TODO:  remove when ItemPedigree becomes an ActiveRecord
    def initialize lot_number, serial_number, vendor, date_received, quantity_received, quantity_remaining
        self.lot_number = lot_number
        self.serial_number = serial_number
        self.vendor = vendor
        self.date_received = date_received
        self.quantity_received = quantity_received
        self.quantity_remaining = quantity_remaining
    end

    def set_display_name

        # TODO:  remove when ItemPedigree becomes an ActiveRecord
        self.display_name = "Test Pedigree"
        # TODO: enable when ItemPedigree becomes an ActiveRecord
#		self.display_name = self.name
	end

end
