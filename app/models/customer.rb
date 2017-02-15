class Customer < ActiveRecord::Base

    after_initialize :initialize_customer

    has_many :customerAllergies
    has_many :customerPlans
    has_many :prescriptions
    has_many :dispenses
    has_many :claims
    has_one  :residency
#    has_many :dependents, class_name: 'Customer', foreign_key: 'head_of_household_id'

# leaving in for now
# TODO: remove these
    has_many :emails
    has_many :faxes
    has_many :phones

    has_many :contact_points, :dependent => :destroy
    has_many :addresses, :dependent => :destroy

    accepts_nested_attributes_for :contact_points
    accepts_nested_attributes_for :addresses

    belongs_to :'head_of_household', class_name: 'Customer', foreign_key: 'head_of_household_id'

    accepts_nested_attributes_for :customerPlans

    enum preferred_contact_method: [:undefined, :home_phone, :cell_phone, :work_phone, :email, :text_message ]
    enum other_language: [:english, :spanish]
    enum gender: [:unspecified, :male, :female]
    enum residence_code: [:not_identified, :at_home, :skilled_facility, :nursing_facility, :assisted_living, :custodial_care, :group_home, :inpatient_psychiatric_facility, :psychiatric_facility, :intermediate_facility, :substance_abuse_facility, :hospice, :psychiatric_residential_treatment, :inpatient_rehab, :homeless_shelter, :correctional_institution]
    enum remote_access: [:no_remote_access, :customer_only, :primary_dr, :all_drs]

#  Default Scope
  default_scope { order('last_name ASC') }


# TODO: new search by phone number
	scope :by_name, -> sourceString { where( nameSearchPattern sourceString ) }
	scope :by_ssn, -> sourceString { where( ssn: sourceString ) }
	scope :by_date_of_birth, -> sourceString {
                                where( birthdate: (sourceString[0,2] + "/" + sourceString[2,2] + "/" +  sourceString[4,4]) ) }
	scope :by_phone_number, -> sourceString { where( phone_number: sourceString ) }

	scope :by_name_with_account, -> sourceString { where( nameSearchPatternwithAccount sourceString ) }
	scope :by_ssn_with_account, -> sourceString {  where("ssn = '#{sourceString}' and account_number > 0") }
	scope :by_date_of_birth_with_account, -> sourceString {
                                where(" birthdate = '%s' and account_number > 0" % [sourceString[0,2] + "/" + sourceString[2,2] + "/" +  sourceString[4,4] ] ) }
	scope :by_phone_number_with_account, -> sourceString { where("phone_number = '#{sourceString}' and account_number > 0" ) }
  scope :by_active,  -> { where("active is TRUE") }
  scope :with_account, -> { where("account_number > 0")}

  # TODO: the following fields need to be properly adjusted
  attr_accessor :reporting_group1
  attr_accessor :reporting_group2
  attr_accessor :reporting_group3


  # caclulated fields
  attr_accessor :age
  after_find :set_age

	attr_accessor :display_name
	after_find :set_display_name

  attr_accessor :head_of_household_name

  # touch the relationships on some fields on initialization
  # mostly used on "newly" instantiated objest required by the "new" action
  def initialize_customer
      # if we haven't come from a find, then preset some attributes needed by the form
      if !self.id.present?
#  additional intialization here ...
      else
        self.head_of_household_name = self.head_of_household.display_name  if self.head_of_household
      end

  end



	#  answer a partial search pattern for:
	#		last name   or
	#		first name, last name

	def self.nameSearchPattern sourceString

		names = sourceString.upcase.split(',')
		if names.count > 1
			"last_name like '#{names[0]}%' and first_name like '#{names[1]}%'"
		else
			"last_name like '#{names[0]}%'"
		end

	end


	#  partial search by:
	#		last name
	#		first name, last name

	def self.search_by_name sourceString

		names = sourceString.upcase.split(',')
		if names.count > 1
			Customer.where "last_name like '#{names[0]}%' and first_name like '#{names[1]}%'"
		else
			Customer.where "last_name like '#{names[0]}%'"
		end

	end


	#  search by:
	#		birthdate

	def self.search_by_dob sourceString
			dateSting = sourceString[0,2] + "/" + sourceString[2,2] + "/" +  sourceString[4,4]
			Customer.where birthdate: dateSting
	end


	#  search by:
	#		ssn
	#		date of birth
	#		phone number
	#		partial name

  def self.search_arel sourceString

		case sourceString

			# SSN
			when /^\d{9}$/
				Customer.by_ssn(sourceString)

			# date of birth
			when /^(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])(19|20|21)\d{2}$/
				Customer.by_date_of_birth(sourceString)

			# phone number
			when /^\d{10}$/
				Customer.by_phone_number(sourceString)

			# name
			else
				Customer.by_name(sourceString)

		end # of case
	end


	def self.paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).page(pageNumber).per(perPage)
	end


  def self.active_paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).by_active().page(pageNumber).per(perPage)
	end

  def self.with_account_paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).with_account().page(pageNumber).per(perPage)
  end


  #  answer the next batch of items
  #  used by Search
  def self.nextCustomers searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial searchItem, startPage, pageSize
      else
          self.paged_search_by_partial searchItem, 1, pageSize
      end
  end

  def self.nextActiveCustomers searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.active_paged_search_by_partial searchItem, startPage, pageSize
      else
          self.active_paged_search_by_partial searchItem, 1, pageSize
      end
  end

  #  answer the next batch of ACTIVE items
  #  used by Search
  def self.nextActiveCustomers searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.active_paged_search_by_partial searchItem, startPage, pageSize
      else
          self.active_paged_search_by_partial searchItem, 1, pageSize
      end
  end


	#  search by:
	#		ssn
	#		date of birth
	#		phone number
	#		partial name

	def self.search_by_partial sourceString

		case sourceString

			# SSN
			when /^\d{9}$/
				Customer.where ssn: sourceString

			# date of birth
			when /^(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])(19|20|21)\d{2}$/
				search_by_dob sourceString

			# phone number
			when /^\d{10}$/
				Customer.where phone_number: sourceString

			# name
			else
				Customer.where nameSearchPattern

		end #of case
	end


    #  answer the next batch of customers
    #  used by Search

    def self.nextCustomers searchFor, startPage=1, pageSize=9

        searchItem = searchFor ? searchFor : ""

        if startPage
            self.paged_search_by_partial searchItem, startPage, pageSize
        else
            self.paged_search_by_partial searchItem, 1, pageSize
        end

    end

    def self.nextCustomersWithAccount searchFor, startPage=1, pageSize=9

        searchItem = searchFor ? searchFor : ""

        if startPage
            self.with_account_paged_search_by_partial searchItem, startPage, pageSize
        else
            self.with_account_paged_search_by_partial searchItem, 1, pageSize
        end

    end


    def set_age
      self.age = 0
      if !self.birthdate.nil?
          now = Time.now.utc.to_date
          self.age = now.year - self.birthdate.to_date.year - ( self.birthdate.to_date.change( year: now.year ) > now ? 1 : 0 )
      end
    end


  def set_display_name
		self.display_name = self.last_name + ", " + self.first_name + " " + self.middle_name
  end

end
