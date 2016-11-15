class User < ActiveRecord::Base

      rolify strict: true

      has_secure_password

#  rolify :before_add => :before_add_method


      belongs_to :employee
      accepts_nested_attributes_for :employee


#  code below is temporary during testing ... to be replaced by Rolify
#    attr_accessor :role
#    enum role: [:user, :admin, :RNAadmin]

#    after_initialize :user_default_role, :if => :new_record?
#    after_initialize :user_default_role

    attr_accessor :role

    scope :by_last_name, -> sourceString { where( 'last_name like ?', sourceString << "%") }

    validates :initials, presence: true, uniqueness: true, length: 3..3  # to become 3..4
    validates :username, presence: true, uniqueness: true, length: 5..20

#    validates_confirmation_of :password
    validates_presence_of :password, :on => :create

# validates :password, :presence     => true,
#                      :confirmation => true,
#                      :length       => { :minimum => 8 },
#                      :if           => :password

    attr_accessor :display_name

    after_find :set_display_name


    # Authenticate the user using the supplied password
    def self.authenticate(username, password)
        if user = where(username: username)
            user.authenticate( password )
        else
            false
        end
    end



    def role_names
        roles.collect{ |r| r.name }
    end

    def role_codes
        roles.collect{ |r| r.code }
    end

    # Provide a pretty display of fullname
    def fullname
        @fullname ||= [self.first_name, self.last_name].compact.join[' ']
    end

    def lastname_first
        @lastname_first ||= [self.last_name, self.first_name].compact.join[', ']
    end


    def set_display_name
        self.display_name = self.last_name + ", " + self.first_name
    end

    # do something before it gets added
    def before_add_method(role)
    end

    # Get the role for the user
    def user_default_role
#        self.role ||= :user #during testing this is only for 'user'
    end

    # Primarily used by scope above to fetch the list of users
    def self.paged_by_last_name sourceString, pageNumber, perPage
        User.by_last_name(sourceString).page(pageNumber).per(perPage)
    end


end
