class DispenseCompound < ActiveRecord::Base
  belongs_to :dispense
  
  enum dosage_form: [ :unspecified, :capsule, :ointment, :cream, :suppository, :powder, :emulsion, :liquid, :obsolete, :not_used, :tablet, :solution, :suspension, :lotion, :shampoo, :elixir, :syrup, :lozenge, :enema ]
  enum dispensing_unit: [ :not_specified, :each, :grams, :milliliters ]
  enum therapy_type: [ :unknown, :anti_infective, :lonotropic, :chemotherapy, :pain_mgmnt, :tpn_or_ppn, :hydration, :opthalmic, :other ]
  enum level_of_Effort: [ :not_reported, :under_5_minutes, :under_15_minutes, :under_30_minutes, :under_45_minutes, :hour ]
end
