class ClaimDur < ActiveRecord::Base
	belongs_to :claim
	
	enum level_of_effort: [ :not_specified, :under_5_minutes, :under_15_minutes, :under_30_minutes, :under_45_minutes, :hour ]
	
end
