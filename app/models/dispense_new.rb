class Dispense < ActiveRecord::Base
  belongs_to :customer
  belongs_to :prescription
  belongs_to :item
  belongs_to :rx_signature
  
  enum posted_flag: [ :not_posted, :posted_to_artx, :posted_to_ar ]
  enum refill_type: [ :retail, :nursing_home ]
  enum status: [ :regular, :profile, :delayed, :expired, :canceled, :renewed, :suspended, :mar ]
  enum partial_fill_status: [ :not_dispensed, :partial_fill, :complete_fill ]
  enum cost_basis: [ :AWP, :ACT, :MAC, :basis_340b, :WAC, :contract, :Nadac, :custom, :user ]
  enum other_coverage_code: [ :other_coverage_unknown, :no_other_coverage, :other_coverage_payment_collected, :other_coverage_not_covered, :other_coverage_payment_not_collected, :billing_for_copay ]
  enum reason_for_delay: [ :no_delay, :eligibiity_unknown, :litigation, :authorization_delay, :provider_certification, :billing_forms, :custom_made, :third_party, :eligibility_determination, :claim_rejected, :administration_delay, :other_delay, :received_late, :provider_damage, :theft ]
  enum reported_to_pmp: [ :no_pmp, :needs_reported, :needs_reversed, :reported, :reversed ] 
  
  
end
