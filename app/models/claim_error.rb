class ClaimError < ActiveRecord::Base
	enum error_type: [ :communications, :universal, :plan ]
end
