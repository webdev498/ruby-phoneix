class PhxResource

	include ActiveModel::Model
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	include ActiveModel::Naming

	cattr_accessor :phx_main_menu_resources

	attr_accessor :name, :type

	def persisted?
		false
	end


	def initialize ( name, type )
		@name = name
		@type = type
	end


  def self.main_menu_resources
	@@phx_main_menu_resources =
		PhxMenu.main_menu.collect { | m |
			PhxResource.new( m, 1 )
		}
  end

end
