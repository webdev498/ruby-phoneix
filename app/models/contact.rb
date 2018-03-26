class Contact < ActiveRecord::Base
	enum entity: [:customer, :prescriber, :pharmacy, :employee, :plan, :facility]
	enum contact_type: [:email, :primaryPhone, :alternatePhone, :cellPhone, :workPhone, :fax]

end
