class Prescription < ActiveRecord::Base

  after_initialize :initialize_prescription

  has_many :dispenses, -> { order 'fill_time desc' }
  has_many :claims

  belongs_to :customer
  belongs_to :item
  belongs_to :prescriber

  accepts_nested_attributes_for :dispenses

  scope :by_customer_id, -> sourceString { where( customer_id: sourceString ) }

  # old enum defn method
  #  enum status: [ :active, :profile, :delayed, :expired, :canceled, :renewed, :suspended, :transferred, :mar ]

  enum rx_type: [ :retail, :nursing_home ]
  enum status: [ :regular, :profile, :delayed, :expired, :canceled, :renewed, :suspended, :transferred, :mar ]
  enum dispense_as_written_code: [ :not_specified, :medically_necessary, :patient, :pharmacist, :generic_unavailable, :brand_as_generic, :override, :state, :brand_unavailable, :other ]
  enum origin_code: [ :unspecified, :written, :phone, :electronic, :fax, :other_origin ]
  enum dea_schedule: [ :non_scheduled, :experimental, :narcotic, :schedule_3, :schedule_4, :schedule_5, :state_mandated ]
  enum diagnosis_code_qualifier: [:undefined_diagnosis, :ICD10, :ICD9, :snomed ]
  enum auto_fill_type: [ :no_auto_fill, :anniversary, :frequency, :procycle ]

  # prescription id from the profile search
	attr_accessor :prescription_id

  # used for profile search trigger
  attr_accessor :profile_trigger

  attr_accessor :dispense_attributes

  # accessors that are not in the prescription model or are to be used during prescription development and testing
	attr_accessor :customer_display_name
	attr_accessor :prescriber_display_name
	attr_accessor :item_display_name

	attr_accessor :payment_type
	attr_accessor :plan_name
	attr_accessor :prescription_price

	attr_accessor :customer_age
	attr_accessor :prescriber_npi_number
	attr_accessor :item_ndc_number
	attr_accessor :quantity_on_hand
	attr_accessor :facility
	attr_accessor :wing
	attr_accessor :account
	attr_accessor :awp

  attr_accessor :customer_birthdate
  attr_accessor :customer_age
  attr_accessor :customer_gender
	attr_accessor :customer_phone
	attr_accessor :item_package_size
#	attr_accessor :discard_date
	attr_accessor :wing
	attr_accessor :balance
	attr_accessor :cost

	attr_accessor :prescriber_phone
	attr_accessor :prescriber_dea_number
	attr_accessor :item_last_awp_update_date
#	attr_accessor :quantity_left
	attr_accessor :room
	attr_accessor :past_due
	attr_accessor :margin
	attr_accessor :percentage

	attr_accessor :pharmacist_initials
	attr_accessor :technician_initials
	attr_accessor :labels

	attr_accessor :lot_number
  attr_accessor :pa_number
	attr_accessor :pa_type
	attr_accessor :diagnosis
	attr_accessor :auto_fill
	attr_accessor :next_fill_date

  attr_accessor :pass_times

	attr_accessor :notes
	attr_accessor :counseling

  attr_accessor :calculated_daily_quantity
  attr_accessor :rxForm_daily_quantity          # displayed on rx primary info panel
  attr_accessor :calculated_days_supply
  attr_accessor :rxForm_days_supply             # displayed on rx primary info panel
  attr_accessor :last_fill_daily_quantity       # not persisted

  attr_accessor :delivery_route

  # TODO: to be moved to dispense when refactoring dispense edit to dispense controller
  attr_accessor :dispForm_dispensed_item

  # touch the relationships on some fields on initializatoin
  # mostly used on "newly" instantiated objest required by the "new" action
  def initialize_prescription
      # if we haven't come from a find, then preset some attributes needed by the form
      if !self.id.present?

          initialize_pass_times
#            self.id ||= 0
          testDispense = Dispense.new
          # testDispense.date = Date.today
          # testDispense.quantity = 0
          testDispense.cost_basis = 0
          # testDispense.fill_price = 0.01

          # per Steve, pay type and amount default to 0
          self.payment_type = 0
          self.prescription_price = 0

          self.active = true
          self.date_written = Date.today
          self.dispenses ||= []
#            self.dispenses = [testDispense, testDispense, testDispense, testDispense, testDispense, testDispense]
      end
  end


  # answer a new dispense if successfull
  # allow an equivalent generic item to be substituted
  # TODO: not quite right sending params to the model; too brittle ... need to refactor this

# answer nil if unable to fill
  def fill fill_date, nextRxNumber, params, rph_initials, tech_initials
      # self is the Rx being refilled
      rxo = Rxoption.first

      # TODO: Steves biz reqmts doc needs review ... then re-visit refillable criteria below
      # TODO: pricing needs to be resolved ... see other verion of prescription.rb
      # TODO: change from default pharmacy 1 (first)

      # process a fill:
      #   on an active prescription with refills remaining or quantity remaining
      #   yes ... this could be one big IF statement ... breaking it up for now
      return nil if params[:customer_id].empty? or params[:prescriber_id].empty? or params[:item_id].empty?

      self.customer = Customer.find params[:customer_id]
      return nil if !self.customer.active

      self.prescriber = Prescriber.find params[:prescriber_id]
      return nil if !self.prescriber.active

      self.item = Item.find params[:item_id]
      return nil if !self.item.active

      ##### TODO: temporarily fix -> defaulting to 1st pharamcy
      self.company_id  = self.pharmacy_id = 1

      fillable =   true
      date_written = DateTime.strptime(params[:date_written], '%m-%d-%Y')
      fillable &&= date_written <= Date.today
      fillable &&= date_written > (Date.today - 1.year)

      if fillable

          self.active = true         # this will be depracated

          #self.active!
          #self.retail!

          self.date_written = date_written

          self.rx_number = nextRxNumber
          self.last_fill_number = 0

          if !params[:refill_through_date].empty?
              refill_through = DateTime.strptime(params[:refill_through_date], '%m-%d-%Y')
              self.refill_through_date = refill_through    if rxo.refill_through_date
          end

          # expiration_date - based on state rxo
          expiration_period = rxo.days_until_expiration.nil? ? 365 : rxo.days_until_expiration.days
          self.expiration_date = self.date_written + expiration_period

          refills = params[:refills_prescribed].to_i
          self.refills_left = refills < 0 ? 0 : refills
          self.original_refills_prescribed = refills

          # quantities
          quantity_prescribed = params[:quantity_prescribed].to_i
          self.quantity_remaining = quantity_prescribed < 0 ? 0 : quantity_prescribed

          # dispense can't be less than 0
          dispense_quantity = params[:last_fill_quantity].to_i < 0 ? 0 : params[:last_fill_quantity].to_i
          self.last_fill_quantity = dispense_quantity

          # quantity remaining (quantity left on screen) - fills * qtyRx + qtyRx - fill quantity
          self.quantity_remaining = quantity_prescribed * refills + quantity_prescribed - dispense_quantity

          # original total quantity - fills * qtyRx + qtyRx
          self.original_total_quantity_prescribed = quantity_prescribed * refills + dispense_quantity

          # grab the screen values and make sure they're not negative
          daily_quantity = params[:rxForm_daily_quantity].to_i < 0 ? 0 : params[:rxForm_daily_quantity].to_i
          days_supply    = params[:rxForm_days_supply].to_i < 0 ? 0 : params[:rxForm_days_supply].to_i

          # daily quantity & supply calculations -> yields calculated values
          # TODO: need to clean up / refactor code calculations below !!
          if daily_quantity == 0 && days_supply ==0   # if both ds and dq are 0/blank then both stay 0
            calculated_days_supply = calculated_daily_quantity = 0
          elsif days_supply ==0
            calculated_days_supply = self.last_fill_quantity / daily_quantity
            calculated_daily_quantity = self.last_fill_quantity
          elsif daily_quantity == 0
            calculated_daily_quantity = days_supply / self.last_fill_quantity
            calculated_days_supply = days_supply
          else # both values were entered and are +ve values
            calculated_days_supply = days_supply
            calculated_daily_quantity = daily_quantity
          end

          self.last_fill_days_supply    = calculated_days_supply
          self.daily_quantity = calculated_daily_quantity

          self.dea_schedule  = self.item.dea_schedule
          self.doc_u_dose_rx = params[:doc_u_dose_rx].empty? ? false : true
          self.rx_type = params[:rx_type]

          self.last_fill_date    = self.date_written
          self.last_fill_price   = params[:prescription_price]
          self.last_fill_primary_paytype = params[:payment_type]

          # self.last_fill_discount

          self.notes      = params[:notes]
          self.counseling = params[:counseling]

          dispense = Dispense.new_dispense_from_prescription self

          # initials have been pre-verified before making it to Prescription
          self.pharmacist_initials = rph_initials
          self.technician_initials = tech_initials
          dispense.pharmacist_initials = self.pharmacist_initials
          dispense.technician_initials = self.technician_initials

          dispense
      else
          nil
      end

  end


  # answer a new dispense if successfull
  # most everything is based on quantity remaining (left)
  # allow an equivalent generic item to be substituted
  # TODO: not quite right sending params to the model ... need to refactor this

# answer nil if unable to refill
  def refill last_dispense, fill_date, item=nil, params, rph_initials, tech_initials
      # self is the Rx being refilled

      rxo = Rxoption.first

      # TODO: generic item substitution
      # TODO: Steves biz reqmts doc needs review ... then re-visit refillable criteria below
      # TODO: pricing needs to be resolved ... see other verion of prescription.rb

      # process a refill:
      #   on an active prescription with refills remaining or quantity remaining
      #   yes ... this could be one big IF statement ... breaking it up for now
      # refills based on quantity, not refills left

      refills = params[:refills_prescribed].to_i
      refill_change = refills - self.refills_prescribed

      refillable =   self.active
      refillable &&= (self.quantity_remaining > 0 || refill_change > 0)
      (refillable &&= self.expiration_date >= fill_date)  if !self.expiration_date.nil?
      refillable &&= Date.today >= fill_date
      (refillable &&= fill_date <= self.refill_through_date) if !self.refill_through_date.nil?
#         refillable &&= fill_date <= self.discard_date if rxo.enter_discard_date

      if refillable
          # if the s increases the # of refills, then it should have been from a Dr approval

          # recalculate the quantity left and refills left
          if refill_change > 0
              self.quantity_remaining += refill_change * self.quantity_prescribed  unless refill_change <= 0
              self.refills_left += refill_change
          end

      		self.refills_left -= 1 unless self.refills_left < 0

          dispense_quantity = params[:last_fill_quantity].to_i   #
          dispense_quantity = dispense_quantity <= 0 ? self.quantity_remaining : [self.quantity_remaining, dispense_quantity].min

          self.quantity_remaining -= dispense_quantity
          days_supply = [params[:last_fill_days_supply].to_i, dispense_quantity].max
          self.last_fill_date = Date.today
          self.last_fill_number += 1

          # grab the screen values and make sure they're not negative
          daily_quantity = params[:rxForm_daily_quantity].to_i < 0 ? 0 : params[:rxForm_daily_quantity].to_i
          days_supply    = params[:rxForm_days_supply].to_i < 0 ? 0 : params[:rxForm_days_supply].to_i

          # daily quantity & supply calculations -> yields calculated values
          # TODO: need to clean up / refactor code calculations below !!
          if daily_quantity == 0 && days_supply ==0   # if both ds and dq are 0/blank then both stay 0
            calculated_days_supply = calculated_daily_quantity = 0
          elsif days_supply ==0
            calculated_days_supply = self.last_fill_quantity / daily_quantity
            calculated_daily_quantity = self.last_fill_quantity
          elsif daily_quantity == 0
            calculated_daily_quantity = days_supply / self.last_fill_quantity
            calculated_days_supply = days_supply
          else # both values were entered and are +ve values
            calculated_days_supply = days_supply
            calculated_daily_quantity = daily_quantity
          end

          self.last_fill_days_supply = calculated_days_supply
          self.daily_quantity  = calculated_daily_quantity

          self.last_fill_price   = params[:prescription_price]
          self.last_fill_primary_paytype = params[:payment_type]

          # self.last_fill_discount

          self.notes      = params[:notes]
          self.counseling = params[:counseling]

          # TODO: change the company and pharmacy after testing

          new_dispense = Dispense.new

          new_dispense.regular!
          new_dispense.company_id  = new_dispense.pharmacy_id = 1
          new_dispense.customer_id = self.customer_id
          new_dispense.item_id     = !item ? self.item_id : item.id  # if the item is supplied
          new_dispense.rx_number   = self.rx_number
          new_dispense.fill_number = self.last_fill_number
          new_dispense.fill_time   = DateTime.now
          new_dispense.quantity    = dispense_quantity
          new_dispense.days_supply = self.last_fill_days_supply
          new_dispense.discard_date = self.expiration_date
          new_dispense.price       = self.last_fill_price    # the last fill price is set above from params

          # initials have been pre-verified before making it to Prescription
          self.pharmacist_initials = rph_initials
          self.technician_initials = tech_initials
          new_dispense.pharmacist_initials = self.pharmacist_initials
          new_dispense.technician_initials = self.technician_initials

          new_dispense
      else
          nil
      end
  end



  def last6dispenses
      (dispenses.sort_by {|a| a.fill_time }).reverse[0..4]
  end


# TODO: !!!!!!!!! FIX STEVE'S DATA CONVERSION ERROR ON FILE TIMESTAMP ... wreaked havock BELOW !!!!!!!!
# TODO: move this to dispense;  even though its an rx, star ratings are based on dispenses
  def star_ratings

      # 5 - 90% or less    of the days supply
	# 4 - 91% to 95%     of the days supply
	# 3 - 95% to 100%    of the days supply
	# 2 - 101% to 105%   of the days supply
	# 1 - 106% to 110%   of the days supply
	# 0 - 111% or greater

    ratings = []
    dd = (dispenses.sort_by {|a| a.fill_time }).reverse[0..10]
    dd.inject(Time.zone.now) do |nextDate, disp|
        if disp.days_supply.nil? || disp.days_supply == 0
            starRating = 0
        else
            daysDiff = (nextDate - (disp.fill_time)).to_i
            pct = (daysDiff.to_f / disp.days_supply.to_f * 100.0).to_i
            starRating = case pct
                when 0..90    then 5
                when 91..95   then 4
                when 95..100  then 3
                when 101..105 then 2
                when 106..110 then 1
                else 0
            end
        end
        ratings << starRating
        disp.fill_time
    end
    ratings
	end


  def initialize_pass_times
    self.pass_times = Array.new(12,"")
  end


  def dislay_name
      item = Item.find self.item_id
      item.display_name
  end


  def customer_display_name
      self.id.present? ? self.customer.display_name : ""
  end


  # if get days supply only then   days_supply = ... calculated
  def calculate_daily_quantity_from days_supply
    calculated_daily_quantity =  days_supply / self.last_fill_quantity
  end

  # if get daily quty only then     daily_quantity = ... calculated
  def calculate_days_supply_from daily_quantity
    calculated_days_supply = quantity_dispensed / daily_quantity
  end


end
