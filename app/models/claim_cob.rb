class ClaimCob < ActiveRecord::Base
	belongs_to :claim
	
	enum payor_id_qualifier: [ :other_number, :hippa_number, :bin_number, :naic_number, :medicare_carrier, :medicare, :medicaid ]
	enum patient_amount_qualifier: [ :patient_amount_not_specified, :applied_to_deductible, :product_selection, :sales_tax, :amount_exceeds_benefit, :copay_amount, :previous_payor_patient_amount, :previous_payor_copay, :non_preferred_formulary, :health_plan_assistance, :provider_network, :brand_product_selection, :coverage_gap, :processor_fee ]
	
end
