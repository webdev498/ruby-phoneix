class PriceSchedule < ActiveRecord::Base

    has_many :priceBreaks, dependent: :destroy
    accepts_nested_attributes_for :priceBreaks

    enum basis: [ :AWP, :ACT, :MAC, :basis_340b, :WAC, :contract, :Nadac, :custom, :user ]
    enum break_type: [ :price_based, :quantity_based ]
    enum qualifier: [ :generic, :brand, :compound, :over_the_counter, :controlled, :unit_dose, :default]
    enum fee_calculation_type: [ :fixed_fee, :graduated_fee ]
    enum usual_customary_calculation: [:lower_of, :higher_of, :not_used ]
    enum customer_assigned_schedule: [ :in_addition_to, :in_place_of, :no_customer_schedule ]
    enum percentage_fee_type: [ :simple_pct_fee, :scheduled_pct_fee, :no_pct_fee ]
    enum amount_fee_type: [ :simple_amount_fee, :scheduled_amount_fee, :no_amount_fee ]


    scope :by_name, -> sourceString { where( nameSearchPattern sourceString ) }


    attr_accessor :display_name

    after_find :set_display_name


    def self.nextPriceSchedules searchFor, startPage=1, pageSize=9
        searchItem = searchFor ? searchFor : ""
        if startPage
            self.paged_search_by_partial searchItem, startPage, pageSize
        else
            self.paged_search_by_partial searchItem, 1, pageSize
        end
    end


    def self.paged_search_by_partial sourceString, pageNumber, perPage
		PriceSchedule.by_name(sourceString).page(pageNumber).per(perPage)
	end


	def self.nameSearchPattern sourceString
		"name like '#{sourceString.upcase}%'"
	end


    def set_display_name
		self.display_name ||= self.name
    end

end
