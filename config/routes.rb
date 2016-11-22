Rails.application.routes.draw do

  # User Authentication

  root :to => "user_sessions#new"
  resources :user_sessions, except: :index    # need to fine tune this ...

  get 'sign_in'                 => 'user_sessions#create',	as: :sign_in
  get 'sign_out'                => 'user_sessions#destroy',	as: :sign_out
  get 'userAccount'	            => 'users#userAccount',		as: :userAccount
  get 'user/nextUsers'          => 'users#nextUsers',         as: :nextUsers
  get 'user/nextEmployees'      => 'users#nextEmployees',     as: :nextUserEmployees
  post 'user/changeEmployee'    => 'users#changeEmployee',    as: :userChangeEmployee
  get 'user/:id'                => 'users#show_user',         as: :get_user

# the :users resource should not be left to default as is done by the resources method
# we set explicit routes for users as above
    resources :users, except: :index
    resources :employees, except: :index do
      resources :users, except: :index
    end
    get 'employee/nextEmployees'    => 'employees#nextEmployees',        as: :nextEmployees

  resources :roles

# Main Navigation Routes

  get 'alert/nextAlerts'		    => 'alerts#nextAlerts',			   as: :nextAlerts
  resources :alerts, except: :index

  get 'settings'					=> 'pages#settings',			   as: :settings
  get 'user_name'					=> 'pages#user_name',              as: :user_name
  get 'topline_search'              => 'pages#topline_search',         as: :topline_search


  # main MENU routes
  #   - use the singular model name for menu originating requests
  get 'prescription/menu'			=> 'prescriptions#new',         as: :menu_prescription
  get 'claims/menu'					=> 'claims#new',                as: :menu_claim
  get 'customer/menu'				=> 'customers#new',             as: :menu_customer
  get 'item/menu'                   => 'items#new',                 as: :menu_item
  get 'prescriber/menu'				=> 'prescribers#new',           as: :menu_prescriber
  get 'plan/menu'                   => 'plans#new',                 as: :menu_plan
  get 'pharmacy/menu'   			=> 'pharmacies#new',            as: :menu_pharmacy
  get 'point_of_sale/menu'			=> 'pos_transactions#new',      as: :menu_point_of_sale
  get 'facility/menu'				=> 'facilities#new',            as: :menu_facility
  get 'account/menu'    			=> 'accounts#new',              as: :menu_finance


# wip - pharamacy
# singular omits the index action
#  get 'company/nextPharmacies'    => 'companies#nextPharmacies',        as: :companyNextPharmacies
  get 'pharmacy/nextPharmacies'    => 'pharmacies#nextPharmacies',        as: :nextPharmacies
  resources :pharmacies, except: :index

  get 'company/nextCompanies'    => 'companies#nextCompanies',        as: :nextCompanies
  resources :companies, except: :index

# prescription
  get 'prescription/newPriceCheck'      => 'items#new_priceCheck',              as: :new_priceCheck
  get 'prescription/priceCheck'         => 'items#priceCheck',                  as: :priceCheck


  get 'prescription/newRxVerfication'   => 'prescriptions#new_rxVerification',  as: :new_rxVerification
  get 'prescription/rxVerification'     => 'prescriptions#rxVerification',      as: :rxVerification
  get 'prescription/findPrescription'       => 'prescriptions#findPrescription',    as: :findPrescription
  get 'prescription/editPrescription/:id'   => 'prescriptions#editPrescription',    as: :editPrescription
  get 'prescription/editPrescriptionRx/:id' => 'prescriptions#editPrescriptionRx',  as: :editPrescriptionRx
  put 'prescription/updatePrescription/:id' => 'prescriptions#updatePrescription',  as: :updatePrescription
  get 'prescription/findDispense'       => 'prescriptions#findDispense',        as: :findDispense
  get 'prescription/editDispense/:id'   => 'prescriptions#editDispense',        as: :editDispense
#  get 'prescription/editDispenseRx/:rx_number' => 'prescriptions#editDispenseRx',   as: :editDispenseRx
  put 'prescription/updateDispense/:id' => 'prescriptions#updateDispense',      as: :updateDispense


  get 'prescription/nextPrescriptions'	=> 'prescriptions#nextPrescriptions',  as: :prescriptionsNextPrescriptions
  get 'prescription/nextCustomers'      => 'prescriptions#nextCustomers',		   as: :prescriptionsNextCustomers
  get 'prescription/nextPrescribers'    => 'prescriptions#nextPrescribers',    as: :prescriptionsNextPrescribers
  get 'prescription/nextItems'          => 'prescriptions#nextItems',          as: :prescriptionNextItems
  get 'prescription/nextDispenses'			=> 'prescriptions#nextDispenses',      as: :prescriptionNextDispenses

  get 'prescription/item/:id'           => 'prescriptions#getItem',             as: :getPrescriptionItem

  get 'prescriptions/refreshSigCache'      => 'prescriptions#refreshSigCache',        as: :prescriptionsRefreshSigCache

  get 'prescription/rx_number/:rx_number' => 'prescriptions#show_rx_prescription',    as: :get_rxprescription
  get 'prescription/:id'                => 'prescriptions#show',                    as: :get_prescription

  resources :prescriptions, except: :index

  # TODO: look into shortening the routes below for e.p.
  get 'electronic_prescription/nextElectronicPrescriptions'	=>  'electronic_prescriptions#nextElectronicPrescriptions',
                                                            as: :electronic_prescriptionsNextElectronicPrescriptions
  get 'electronic_prescription/nextElectronicPrescriptionsByCustomer'	=>  'electronic_prescriptions#nextElectronicPrescriptionsByCustomer',
                                                            as: :electronic_prescriptionsNextElectronicPrescriptionsByCustomer
  get 'electronic_prescription/nextElectronicPrescriptionsByPrescriber'	=>  'electronic_prescriptions#nextElectronicPrescriptionsByPrescriber',
                                                            as: :electronic_prescriptionsNextElectronicPrescriptionsByPrescriber
  get 'electronic_prescription/nextElectronicPrescriptionsByItem'	=>  'electronic_prescriptions#nextElectronicPrescriptionsByItem',
                                                            as: :electronic_prescriptionsNextElectronicPrescriptionsByItem
  get 'electronic_prescription/:id' => 'electronic_prescriptions#show', as: :get_electronic_prescription
  resources :electronic_prescriptions, except: :index

  # get 'printQueue/contents'             => 'print_queue#contents',         as: :getQueueContents
  # get 'printQueue/label/:rxno'          => 'print_queue#getRxLabel',       as: :getRxLabel
  get 'printQueue/getNextPrint/:pwd'    => 'print_queue#getNextPrint',     as: :getNextPrint

  resources :dispenses

  get 'item/clinicalInquiry'			  => 'items#clinicalInquiry',	as: :clinicalInquiry
  get 'item/nextItems'				   	  => 'items#nextItems',	        as: :nextItems   # arggggghhh !!!!
  get 'item/:id'                          => 'items#show_item',         as: :get_item
  get 'item/addCompoundItem/:id,:cid'     => 'items#addCompound',       as: :addCompoundItem
  get 'item/removeCompoundItem/:id,:cid'  => 'items#removeCompound',    as: :removeCompoundItem
  get 'item/nextIngredients' => 'items#nextIngredients'
  get 'item/nextExistingIngredients' => 'items#nextExistingIngredients'
  get 'item/nextItemFormulaToCopy' => 'items#nextItemFormulaToCopy'
  get 'item/ingredient_details/:id' => 'items#ingredient_details'
  put 'item/copyFormula' => 'items#copyFormula'

  resources :items, except: :index do
    resources :formulas do
      resources :ingredients
    end
  end


  get 'price_schedule/nextPriceSchedules'		=> 'price_schedules#nextPriceSchedules',		as: :price_schedulesNextPriceSchedules
  resources :price_schedules, except: :index

  resources :vendors, except: :index

  resources :contact_points, except: :index
  resources :addresses, except: :index

# customer
  get 'customer/nextCustomers'        => 'customers#nextCustomers',         as: :customersNextCustomers
#  get 'customer/:id'   		          => 'customers#show_customer',         as: :get_customer
 # match "/customers" => "customers#index", :as => :index, :via => [:get]

  get 'customers/search_active' => "customers#search_active"
  get 'customers/search' => "customers#search"
  get 'customers/search_customer' => "customers#search_customer"

  resources :customers
  # resources :customers, except: :index do
  #   resources :contact_points
  #   resources :addresses
  # end

  get 'plans/search' => "plans#search"

  get 'claims/search' => "claims#search"
  get 'claims/search_cob' => "claims#search_cob"
  get 'claims/search_dur' => "claims#search_dur"

  resources :plans do
    resource :plan_requirement
  end
  resources :customers do
    resources :customer_plans
  end

  resources :prescriptions

  resources :price_schedules

  resources :claims

  get 'sigCodes'              => 'sigcodes#sigCode',        as: :sigCode
  get 'sigcode/nextSigcodes'  => 'sigcodes#nextSigcodes',   as: :sigcodeNextSigcodes
  resources :sigcodes, except: :index

  get 'parameterMaintenance'   => 'rxoptions#parameterMaintenance',         as: :parameterMaintenance
  resources :rxoptions

  get 'claimErrors'       => 'claim_errors#claimError',     as: :claimError
  resources :claim_errors

  get 'claim/nextClaims'    => 'claims#nextClaims',        as: :nextClaim
  resources :claims


  get 'prescriber/nextPrescribers'  => 'prescribers#nextPrescribers',   as: :prescriberNextPrescribers

  get 'prescriber/supervisor/:id'   => 'prescribers#supervisor',                 as: :prescriberSupervisor
  get 'prescriber/supervising'      => 'prescribers#supervising',                as: :prescriberSupervising
  get 'prescriber/nextSupervising'  => 'prescribers#nextSupervisePrescribers',   as: :prescriberNextSupervising
  get 'prescriber/addSupervisor'    => 'prescribers#addSupervisorPrescriber',    as: :addPrescriberSupervisor
  get 'prescriber/addSupervisee'    => 'prescribers#addSuperviseePrescriber',    as: :addPrescriberSupervisee
  get 'prescriber/supervisors'      => 'prescribers#changeSupervisors',          as: :new_prescriberSupervisors

  # testing prescriber route before menus
  resources :prescribers, except: :index do |variable|
      resources :supervising_prescribers, except: :index
  end

#get 'prescribers' => "prescribers#show"
#get 'prescribers/:id(.:format)' => 'prescribers#show'

# POS
#  get 'posCategory'     => 'posCategories#posCategory',         as: :posCategory
#  get 'posItems'          => 'rxoptions#parameterMaintenance',     as: :parameterMaintenance
#  get 'posPaymentMethods' => 'rxoptions#parameterMaintenance',     as: :parameterMaintenance
#  get 'posTax'            => 'rxoptions#parameterMaintenance',     as: :parameterMaintenance

  resources :pos_transactions
  resources :pos_details

  get 'posCategories'         => 'pos_categories#posCategory',              as: :posCategory
  resources :pos_categories

  get 'posPaymentMethods'     => 'pos_payment_methods#posPaymentMethod',    as: :posPaymentMethod
  resources :pos_payment_methods

  resources :pos_taxes

  resources :facilities

  #  * Accounts Recieveable
  get 'account/nextAccountPostings' => 'accounts#next_account_postings'
  get 'accounts/nextAccountPostings' => 'accounts#next_account_postings'
  get 'account/nextAccounts' => 'accounts#next_accounts'
  get 'accounts/nextAccounts' => 'accounts#nextAccounts'

  get 'accounts/show_by_account_number/:id' => 'accounts#show_by_account_number'
  get 'accounts/account_postings' => 'accounts/account_postings'
  get 'accounts' => 'accounts#index'
  get 'accounts/:id' => 'accounts#show_by_account_number'
  resources :accounts

# For Phoenix, bring theses routes forward ... if and when needed
  resources :claim_preferences
  resources :claim_durs
  resources :claim_cob_responses
  resources :claim_cobs
  resources :claim_clinicals
  resources :claim_prior_auths
  resources :claim_coupons
  resources :claimcobs
  resources :claim_authorizations

  resources :plans
  resources :price_histories
  resources :contacts
  resources :licenses

end
