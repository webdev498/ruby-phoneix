class PhxResourceGroup

	include ActiveModel::Model
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	include ActiveModel::Naming

	cattr_accessor :phx_sub_menu
	cattr_accessor :phx_submenu_resources

	attr_accessor :name, :type, :phx_resources

	def persisted?
		false
	end


	def self.level
		:m_menu_prescription
	end


	def initialize ( name, level )
		@name = name
		@level = level
	end



  def self.initialize_main_menu
	@@phx_main_menu =
	  [	:m_prescription,
		:m_claim,
		:m_customer,
		:m_item,
		:m_prescriber,
		:m_3rdParty,
		:m_pharmacy,
		:m_pos,
		:m_facility,
		:m_receivables ]
  end


  def self.phx_menu_resources
  	@@phx_main_menu ||= self.initialize_main_menu
	@@phx_menu_resources =
		@@phx_main_menu.each { | m |
			r = PhxResource.new( m, 1 )
		}
  end

end
