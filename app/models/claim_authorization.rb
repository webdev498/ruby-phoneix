class ClaimAuthorization < ActiveRecord::Base
	belongs_to :claim
	enum claim_type: [:claim, :reversal ]
end
