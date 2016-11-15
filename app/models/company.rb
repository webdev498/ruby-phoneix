class Company < ActiveRecord::Base

    has_many :pharamcies

    scope :by_name, -> sourceString { where("name like '#{sourceString.upcase}%'") }


    attr_accessor :display_name

    after_find :set_display_name


	def self.paged_search_by_partial sourceString, pageNumber, perPage
		Company.by_name(sourceString).page(pageNumber).per(perPage)
	end

    def set_display_name
        self.display_name = self.name
    end

end
