class Pharmacy < ActiveRecord::Base

    enum pharmacy_type: [ :retail, :mail_order, :specialty, :long_term_care, :other ]
    enum us_or_metric: [ :US, :metric ]

    attr_accessor :display_name

	after_find :set_display_name

    scope :by_pharmacy_name, -> sourceString { where("pharmacy_name like '#{sourceString.upcase}%'") }

    def self.paged_search_by_partial sourceString, pageNumber, perPage
		self.by_pharmacy_name(sourceString).page(pageNumber).per(perPage)
	end


	def set_display_name
		self.display_name = self.pharmacy_name
	end

end
