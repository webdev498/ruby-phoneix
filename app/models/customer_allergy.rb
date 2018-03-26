class CustomerAllergy < ActiveRecord::Base
	belongs_to :customer
	
	enum allergy_type: [ :class, :ingredient ]
end
