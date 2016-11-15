class ClaimsSearchParameter

	include ActiveModel::Model

	attr_accessor :view_all_claims
	attr_accessor :rx_number
	attr_accessor :fill_number
	attr_accessor :customer
	attr_accessor :plan
	attr_accessor :from_date
	attr_accessor :status

	# validates :rx_number
	# validates :view_all_claims
	# validates :fill_number
	# validates :customer
	# validates :plan
	# validates :date
	# validates :status

  def initialize
	@view_all_claims = false
	@rx_number = 0
	@fill_number = 0
	@customer = ""
	@plan = 0
	@from_date = Date.today
	@status = ""
  end

end