class Employee < ActiveRecord::Base

    has_many :users

    scope :by_last_name, -> sourceString { where("last_name like '#{sourceString.upcase}%'") }

    validates_presence_of :last_name
    validates_presence_of :first_name, message: "First Name can't be blank"
    validates_presence_of :employee_id_number
#    validates_presence_of :employee_type
#    validates_presence_of :social_security_number
    validates :initials, presence: true, uniqueness: true, length: 3..3  # to become 3..4

    attr_accessor :display_name

    after_find :set_display_name


	def self.paged_search_by_partial sourceString, pageNumber, perPage
		Employee.by_last_name(sourceString).page(pageNumber).per(perPage)
	end

    def set_display_name
        self.display_name = self.last_name + ", " + self.first_name
    end

end
