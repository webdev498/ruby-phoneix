class Alert < ActiveRecord::Base

	scope :all_active, -> { where( active: true ) }
	scope :active_count, -> { where( active: true ).count() }


	after_initialize :init

	def init
		self.uuid				||= SecureRandom.uuid
		self.event_time	||= Time.now
		self.active			||= false
		self.viewed			||= false
		self.viewed_by	||= ""
	end

end
