class PhxUserContext

	include ActiveModel::Model
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	include ActiveModel::Naming

	attr_accessor :user, :session, :menu, :menu_type

	def persisted?
		false
	end


	def initialize ( user, session, menu, menu_type )
		@user    = user
		@session = session
		@menu    = menu
		@menu_type = menu_type
	end

end
