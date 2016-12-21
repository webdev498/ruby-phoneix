class Facility < ActiveRecord::Base

	has_many :wings
	has_many :beds

	accepts_nested_attributes_for :wings
	accepts_nested_attributes_for :beds

	enum print_monograph: [:noMonogrpah, :monoOnNew, :monoOnRf, :monoOnBoth]
	enum require_hippa_privacy_notice: [:noHippa, :required, :issueWarning]
	enum print_order: [:alphabetic, :passOrder]
	enum type_of_facility: [:undefined, :skilled, :intermediate, :nursing, :assistedLiving, :groupHome, :mentalHealth, :correctional]


	# facility options
	attr_accessor :use_patient_counseling
	attr_accessor :select_counseling
	attr_accessor :print_patient_counseling
	attr_accessor :print_monograph
	attr_accessor :check_dur
	attr_accessor :print_medication_administration_form
	attr_accessor :print_physician_order_form
	attr_accessor :print_treatment_form
	attr_accessor :print_delivery_receipt
	attr_accessor :print_fill_date
	attr_accessor :print_original_date
	attr_accessor :label_type
	attr_accessor :label_default
	attr_accessor :universal_fee
	attr_accessor :unit_dose_fee
	attr_accessor :control_drug_fee
	attr_accessor :narcotic_fee
	attr_accessor :use_auto_fill
	attr_accessor :use_lot_number
	attr_accessor :use_doc_u_dose
	attr_accessor :use_valid_division_codes
	attr_accessor :default_to_primary_plan

end
