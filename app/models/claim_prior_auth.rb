class ClaimPriorAuth < ActiveRecord::Base
	belongs_to :claim
	enum authorization_basis: [ :medical_exception, :plan_requirement, :increase_limitations, :no_authorization ]
	enum request_type: [ :no_request, :initial, :renewal, :deferred ]
end
