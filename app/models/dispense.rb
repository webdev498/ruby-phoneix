class Dispense < ActiveRecord::Base

	after_initialize :initialize_dispense

	belongs_to :prescription
	belongs_to :item
        belongs_to :customer
        has_many :rx_payments

	enum posted_flag: [ :not_posted, :posted_to_artx, :posted_to_ar ]
	enum refill_type: [ :retail, :nursing_home ]
	enum status: [ :regular, :profile, :delayed, :expired, :canceled, :renewed, :suspended, :mar ]
	enum partial_fill_status: [ :not_dispensed, :partial_fill, :complete_fill ]
	enum cost_basis: [ :AWP, :ACT, :MAC, :basis_340b, :WAC, :contract, :Nadac, :custom, :user ]
	enum other_coverage_code: [ :other_coverage_unknown, :no_other_coverage, :other_coverage_payment_collected, :other_coverage_not_covered, :other_coverage_payment_not_collected, :billing_for_copay ]
	enum reason_for_delay: [ :no_delay, :eligibiity_unknown, :litigation, :authorization_delay, :provider_certification, :billing_forms, :custom_made, :third_party, :eligibility_determination, :claim_rejected, :administration_delay, :other_delay, :received_late, :provider_damage, :theft ]
	enum reported_to_pmp: [ :no_pmp, :needs_reported, :needs_reversed, :reported, :reversed ]

	scope :by_rna_customer_id_number, -> sourceString { where( rna_customer_id_number: sourceString ) }

	attr_accessor :just_fill_date
	attr_accessor :just_fill_time

	attr_accessor :dispensed_item_name

	# attr_accessor :notes
	# attr_accessor :counseling


	# touch the relationships on some fields on initializatoin
    # mostly used on "newly" instantiated objest required by the "new" action
    def initialize_dispense
        # if we haven't come from a find, then preset some attributes needed by the form
        if !self.id.present?
#  additional initialization here
				else
					self.just_fill_date = self.fill_time
					self.just_fill_time = self.fill_time
        end

    end

#
  # TODO: set dispense status based on conditions (other than just regular)
	# TODO: need to determine whether rph & tech initial s/b set here
	def self.new_dispense_from_prescription prescription

		fill = self.new
		fill.fill_number = 1

		fill.retail!  			# refill_type s/b provided via instantiation - default retail for now
		fill.regular!				# fill status set to the default to regular for now

		fill.rx_number        = prescription.rx_number

		fill.company_id       = 1  # temporary value
		fill.pharmacy_id      = 1  # temporary value
		fill.customer         = prescription.customer
		fill.item             = prescription.item

		fill.delivery_route		= prescription.delivery_route
		fill.fill_time        = Time.now
		fill.fill_number      = prescription.last_fill_number

		fill.quantity    			= prescription.last_fill_quantity
		fill.days_supply      = prescription.last_fill_days_supply

		fill.discard_date     = fill.fill_time + prescription.item.discard_age_days

		fill.price						= prescription.last_fill_price

		# not_dispensed when: profile rx or profile only
		# partial_fill when: qty dispensed < qty prescribed for a single dispense (not the total qty prescribed)
		# complete_fill when: qty dispensed >= qty prescribed for a single dispense (not the total qty prescribed)
		#    and ... <= total qty prescribed ... can never be > than total qty prescribed
		fill.complete_fill!

		# partial_fill_status


		#		fill.lot_number
		#		fill.serial_number

		# TODO: need this from pmt
		# fill.usual_customary_price
		# fill.base_cost
		# fill.actual_cost
		# fill.cost_basis
		# fill.fee
		# fill.discount
		# fill.tax
		# fill.ancillary_fee
		# fill.professional_service_fee
		# fill.other_coverage_code
		# fill.other_amount
		# fill.other_amount_type
		# fill.prior_auth_type
		# fill.reason_for_delay
		# fill.denial_override_code

		fill
	end


	def self.paged_search_by_rna_customer_id_number sourceString, pageNumber, perPage
		Dispense.by_rna_customer_id_number(sourceString).page(pageNumber).per(perPage)
	end


	#  answer the next batch of Prescribers

    def self.nextDispenses searchFor, startPage=1, pageSize=9

        searchDispense = searchFor ? searchFor : ""

        if startPage
            self.paged_search_by_partial searchDispense, startPage, pageSize
        else
            self.paged_search_by_partial searchDispense, 1, pageSize
        end

    end


	def display_name
		self.item_name
	end

end
