class Role < ActiveRecord::Base

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  cattr_reader :phx_roles
#  cattr_reader :phx_roles_codes
#  cattr_reader :phx_role_descriptions

  # class methods

  @@phx_role_codes =
	  { usr_rph:		101,
		usr_tech:		102,
		usr_manager:	103,
		usr_associate:	104,
		usr_cashier:	105,
		usr_finance:	106,
		mdd_doctor:		201,
		cst_customer:	301,
		lcl_admin:		401,
		crp_admin:		501,
		usr_owner:		601,
		phx_support:	901,
		phx_auto:		921,
		phx_api:		951,
		phx_lms:		991,
		phx_admin:		998 }

  @@phx_role_descriptions =
	  { usr_rph:		"Pharmacist",
		usr_tech:		"Technician",
		usr_manager:	"Manager",
		usr_associate:	"Sales Associate",
		usr_cashier:	"Cashier",
		usr_finance:	"Finance",
		mdd_doctor:		"Doctor",
		cst_customer:	"Customer",
		lcl_admin:		"Local Administrator",
		crp_admin:		"Corporate Administrator",
		usr_owner:		"Owner",
		phx_support:	"Phoenix Support",
		phx_auto:		"Phoenix Automated",
		phx_api:		"Phoenix API",
		phx_lms:		"Phoenix License Management",
		phx_admin:		"Phoenix Administrator" }


    def self.setup_roles
     	{ usr_rph:      Role.new( name:"usr_rph", code:111, description:"Pharmacist"),
        usr_tech:       Role.new( name:"usr_tech", code:102, description:"Technician"),
        usr_manager:    Role.new( name:"usr_manager", code:103, description:"Manager"),
        usr_associate:  Role.new( name:"usr_associate", code:104, description:"Sales Associate"),
        usr_cashier:    Role.new( name:"usr_cashier", code:105, description:"Cashier"),
        usr_finance:    Role.new( name:"usr_finance", code:106, description:"Finance"),
        mdd_doctor:     Role.new( name:"mdd_doctor", code:201, description:"Doctor"),
        cst_customer:   Role.new( name:"cst_customer", code:301, description:"Customer"),
        lcl_admin:      Role.new( name:"lcl_admin", code:401, description:"Local Administrator"),
        crp_admin:      Role.new( name:"crp_admin", code:501, description:"Corporate Administrator"),
        usr_owner:      Role.new( name:"usr_owner", code:601, description:"Owner"),
        phx_support:    Role.new( name:"phx_support", code:901, description:"Phoenix Support"),
        phx_auto:       Role.new( name:"phx_auto", code:921, description:"Phoenix Automated"),
        phx_api:        Role.new( name:"phx_api", code:951, description:"Phoenix API"),
        phx_lms:        Role.new( name:"phx_lms", code:991, description:"Phoenix License Management"),
        phx_admin:      Role.new( name:"phx_admin", code:998, description:"Phoenix Administrator")
        }
    end

    @@phx_roles ||= self.setup_roles

    def self.all_descriptions
        @@phx_roles.collect {|k,v| v.description }
    end

    def self.all_names
        @@phx_roles.collect {|k,v| v.name }
    end

end
