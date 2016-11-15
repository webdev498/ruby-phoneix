class ContactPoint < ActiveRecord::Base

	enum kind: { other: 0, phone: 1, fax: 2, mobile: 3, pager: 4, email:10 , twitter: 20, facebook: 21 }
	enum use:  { alternate: 0, work: 1, home: 2, temporary: 3 }

	# leave as discrete for now ...
	# TODO: polymorphize the belongs_to

	belongs_to :customer
	belongs_to :prescriber

end
