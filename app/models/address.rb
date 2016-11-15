class Address < ActiveRecord::Base

	enum kind: { other: 0, physical: 1, postal: 2 }
	enum use:  { alternate: 0, work: 1, mobile: 2, home: 3, temporary: 4 }

	# leave as discrete for now ...
	# TODO: polymorphize the belongs_to

	belongs_to :customer
	belongs_to :prescriber

	# manually limiting it to 2 street lines
	attr_accessor :street1
	attr_accessor :street2


	def initialize_customer
			# if we haven't come from a find, then preset some attributes needed by the form
			if !self.id.present?
				self.street1 = ""
				self.street2 = ""
				#  additional intialization here ...
			else
				self.street1 = self.street[0]  if self.street
				self.street2 = self.street[1]  if self.street
			end

	end


end
