class ClaimCoupon < ActiveRecord::Base
	belongs_to :claim
	enum coupon_type: [ :not_specified, :discount, :free, :other ]

end
