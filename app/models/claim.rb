# RNA Holdings, LLC - COPYRIGHT and INTELLECTUAL PROPERTY NOTICE:
# This source code contains copyrighted material and other confidential and proprietary information
# that is wholly owned by RNA Holdings, LLC d/b/a Mobile MedSoft, LLC.  All rights reserved.

class Claim < ActiveRecord::Base

	belongs_to :customer
	belongs_to :prescription
	belongs_to :plan
        belongs_to :dispense

	has_many :claimAuthorizations
	has_many :claimClinicals
	has_many :claimCobs
	has_many :claimCobResponses
	has_many :claimCoupons
	has_many :claimDurs
	has_many :claimPreferences
	has_many :claimPriorAuth

	accepts_nested_attributes_for :claimPreferences
	accepts_nested_attributes_for :claimClinicals
	accepts_nested_attributes_for :claimPriorAuth
	accepts_nested_attributes_for :claimCobs
	accepts_nested_attributes_for :claimDurs

#**** TODO: during testing just find all
	scope :by_rx_number, -> sourceString { }


    enum status: [:paid, :duplicate, :captured, :accepted, :rejected, :pending]
    enum transmission_code: [ :claim, :reversal, :rebill, :eligibility_check ]
    enum cost_basis: [ :default, :awp, :local_wholesaler, :direct, :eac, :acquisition, :mac, :usual_and_customary, :basis_340b, :other, :average_sales_price, :average_mfg_price, :wac, :special_patient_pricing, :unreportable_qty, :free ]
    enum product_type: [ :single_source, :generic, :supply, :brand_otc, :generic_otc, :any ]
    enum percentage_tax_basis_submitted: [ :no_pct_basis, :pct_cost, :pct_cost_fee, :pct_cost_fee_Service ]
    enum reimbursement_basis: [ :not_specified, :paid_as_submitted, :reduced_to_awp, :reduced_to_awp_less_pct, :paid_usual_and_customary, :paid_lower_of_contract_uc, :mac_paid, :reduced_to_mac, :contract_pricing, :acquisition_cost, :reimburse_average_sales_price, :reimburse_average_mfg, :reimburse_340b, :reimburse_wac, :other_payor_patient_amount, :patient_amount, :coupon_payment, :special_patient_reimburse, :reimburse_direct_price ]
    enum tax_basis_paid: [ :basis_not_specified, :based_on_qty_dispensed, :based_on_qty_written ]
    enum other_coverage_code: [ :other_coverage_unknown, :no_other_coverage, :other_coverage_payment_collected, :other_coverage_not_covered, :other_coverage_payment_not_collected, :billing_for_copay ]

	# TODO: fields below need to be resolved
	attr_accessor :amount_due_filler


#	Search Parameters .. to be deprecated
	attr_accessor :search_for_all_claims
	attr_accessor :search_for_rx_number
	attr_accessor :search_for_fill_number
	attr_accessor :search_for_customer
	attr_accessor :search_for_plan
	attr_accessor :search_for_from_date
	attr_accessor :search_for_status

	attr_accessor :dur_messages


	def self.paged_search_by_partial sourceString, pageNumber, perPage
		self.by_rx_number(sourceString).page(pageNumber).per(perPage)
	end

	def self.format_claim_and_send
		# TODO call method to format claim
		self.send_remote_claim_request
	end

	def self.send_remote_claim_request
		redis = Redis.new(:host => "127.0.0.1", :port => 6379)

    @demo_request = "007250D0B1TESTVD01  1010005123708     20161214VD0RRR    AM01CX01CY123456789C419610416C52CADANACBJOHNSONCM1801 NORMAN DRIVECNPINE LAKECOGACP30093CQ4047541821C71CZXYZ123AM04C2987654321AM07EM1D21463450E103D700006094268E730000D30D530D61D80DE20161214DF5DJ1NX1DK1DT128EAAM02EY05E93935939359AM03EZ01DB1234566119DRWRIGHTPM20136395722E01DL12345661194EWRIGHTAM11D9557{DC100{H71H801H9150{DQ807{DU807{DN03"
    @job_id = Time.now.to_i
    payload = {
        jobid: @job_id
    }
      payload[:request] = @demo_request
      job_id = Time.now.to_i + rand(1000)
    payload[:job_id] = job_id

    msg = {'class' => 'ClaimRequestSenderWorker', 'args' => payload, 'jid' => job_id, 'retry' => false, 'enqueued_at' => Time.now.to_f}
    redis.lpush("queue:claims_send_and_process_response", JSON.dump(msg))
		return @job_id
	end

	def self.request_format_and_send
		# TODO place Redis configuration into yaml file
		redis = Redis.new(:host => "127.0.0.1", :port => 6379)
		payload = {

		}
		job_id = Time.now.to_i + rand(1000)
		message = {"class" => "ClaimFormatAndSendWorker", "args" => payload, "jid" => job_id, "retry" => false, "enqueued_at" => Time.now.to_f}
		redis.lpush("queue:claims_preprocess_and_request_send", JSON.dump(message))
	end

end
