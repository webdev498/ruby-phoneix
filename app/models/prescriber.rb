class Prescriber < ActiveRecord::Base

	after_initialize :initialize_prescriber

	before_save :force_uppercase

	has_many :prescriptions
	has_many :supervisors, through: :supervisor_manages, source: :supervisor
	has_many :supervisor_manages,  foreign_key: "supervisee_id", class_name: "SupervisingPrescriber"
	has_many :supervisees, through: :supervisee_manages, source: :supervisee
	has_many :supervisee_manages,  foreign_key: "supervisor_id", class_name: "SupervisingPrescriber"
  has_many :contact_points
  has_many :addreses

	enum receive_messages: [:no_messages, :email, :text, :fax, :all_messages]
	enum alternate_id1_qualifier: [:not_specified, :NPI, :blue_cross, :blue_shield, :medicare, :medicaid, :UPIN, :NCPDP, :state_number, :tricare, :HIN, :federal_tax_id, :DEA, :state_issued, :plan_specific, :other]
	enum alternate_id2_qualifier: [:id2_not_specified, :id2_NPI, :id2_blue_cross, :id2_blue_shield, :id2_medicare, :id2_medicaid, :id2_UPIN, :id2_NCPDP, :id2_state_number, :id2_tricare, :id2_HIN, :id2_federal_tax_id, :id2_DEA, :id2_state_issued, :id2_plan_specific, :id2_other]
	enum alternate_id3_qualifier: [:id3_not_specified, :id3_NPI, :id3_blue_cross, :id3_blue_shield, :id3_medicare, :id3_medicaid, :id3_UPIN, :id3_NCPDP, :id3_state_number, :id3_tricare, :id3_HIN, :id3_federal_tax_id, :id3_DEA, :id3_state_issued, :id3_plan_specific, :id3_other]
	enum alternate_id4_qualifier: [:id4_not_specified, :id4_NPI, :id4_blue_cross, :id4_blue_shield, :id4_medicare, :id4_medicaid, :id4_UPIN, :id4_NCPDP, :id4_state_number, :id4_tricare, :id4_HIN, :id4_federal_tax_id, :id4_DEA, :id4_state_issued, :id4_plan_specific, :id4_other]

# TODO: search by phone number

	scope :by_name, -> sourceString { where( nameSearchPattern sourceString ) }
	scope :by_npi_number, -> sourceString { where( npi_number: sourceString ) }
	scope :by_dea_number, -> sourceString { where( dea_number: sourceString ) }
	scope :by_active,  -> { where("active is TRUE") }
#	scope :by_phone_number, -> sourceString { where( phone_number: sourceString ) }

#  Default Scope
  default_scope { order('last_name ASC') }


	# additional accessor needed for Supervising prescriber form-group
	# this field is used in the form for each supervisee/supervisor purely as a mechanism to distinguish DELETE
	# it is NOT persisted to the database
	attr_accessor :remove_supervision
	attr_accessor :search_supervisor_id
	attr_accessor :search_supervisee_id

	attr_accessor :phone1
	attr_accessor :phone2
	attr_accessor :mobile1
	attr_accessor :home_phone1
	attr_accessor :fax1
	attr_accessor :email1

	attr_accessor :display_name
	attr_accessor :prescribing_phone

	after_find :set_display_name
  after_find :set_prescribing_phone

	# touch the relationships on some fields on initializatoin
	# mostly used on "newly" instantiated objest required by the "new" action
	def initialize_prescriber

		# if we haven't come from a find, then preset some attributes needed by the form
		if !self.id.present?
#			self.id ||= 0
			self.active = true
# self.supervisors=[] unless self.supervisors.present?
# self.supervisees=[] unless self.supervisees.present?
		end
	end

	def prepare_contact_points_for_view
		# argggghhhh very ugly code below
		# # TODO: fix this
		self.contact_points.each do |cp|
				self.phone1 = cp.contact    if cp.phone? && cp.rank == 1
				self.phone2 = cp.contact    if cp.phone? && cp.rank == 2
				self.fax1 = cp.contact      if cp.fax?
				self.mobile1 = cp.contact   if cp.mobile?
				self.home_phone1 = cp.contact  if cp.home?
				self.email1 = cp.contact    if cp.email?
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
			Prescriber.where "last_name like '#{names[0]}%' and first_name like '#{names[1]}%'"
		else
			Prescriber.where "last_name like '#{names[0]}%'"
		end

	end


	#  search using above SCOPES by:
	#		dea #
	#		npi #
	#		name

	def self.search_arel sourceString
		case sourceString

			# DEA ( e.g. AA1234567)
			when /^[A-Z]{2}\d{7}[A-Za-z0-9]?$/
				Prescriber.by_dea_number(sourceString)

			# NPI
			when /^\d{10}$/
				Prescriber.by_npi_number(sourceString)

			# name
			else
				Prescriber.by_name(sourceString)
		end
	end


	def self.paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).page(pageNumber).per(perPage)
	end


  def self.active_paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).by_active().page(pageNumber).per(perPage)
	end


	def self.nextPrescribers searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial searchItem, startPage, pageSize
      else
          self.paged_search_by_partial searchItem, 1, pageSize
      end
  end


  #  answer the next batch of ACTIVE items
  #  used by Search
  def self.nextActivePrescribers searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.active_paged_search_by_partial searchItem, startPage, pageSize
      else
          self.active_paged_search_by_partial searchItem, 1, pageSize
      end
  end



	def set_display_name
		self.display_name = self.last_name + ", " + self.first_name + "  " + self.middle_name
		self.display_name += " (" + self.specialty + ")"  unless self.specialty.blank?
	end

	def set_prescribing_phone
		cp = self.contact_points.find { |cp| cp.phone? && cp.rank == 1 }
		self.prescribing_phone = cp.contact    if cp.present?
	end


	# The four methods below are a temporary kludge
	def add_supervisor supervisor
		SupervisingPrescriber.add_supervision supervisor, self
	end

	def add_supervisee supervisee
		SupervisingPrescriber.add_supervision self, supervisee
	end

	# TODO: dummy data below
# 	def supervisors
# #		return [Prescriber.find(5), Prescriber.find(30), Prescriber.find(95), Prescriber.find(150), Prescriber.find(138)]
# 		return [Prescriber.find(5), Prescriber.find(30)]
# 	end

	# # TODO: dummy data below
	# def supervisees
	# 	return [Prescriber.find(15), Prescriber.find(130), Prescriber.find(122)]
	# end

  private

	# selectively force certain fields to be uppercase
	# leave fields such as notes and memos alone
	def force_uppercase
		self.last_name.upcase!
		self.first_name.upcase!
		self.address1.upcase!
		self.address2.upcase!
	end

end
