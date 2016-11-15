class CreateFacilityOptions < ActiveRecord::Migration
  def change
    create_table :facility_options do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.integer :price_based_pricing_schedule, array: true
      t.decimal :universal_fee, precision: 4, scale: 2
      t.decimal :unit_dose_fee, precision: 4, scale: 2
      t.decimal :control_drug_fee, precision: 4, scale: 2
      t.decimal :narcotic_fee, precision: 4, scale: 2
      t.boolean :allow_customer_discount
      t.string :label_type, limit: 2
      t.boolean :spool_labels
      t.integer :label_default
      t.boolean :expiration_date
      t.integer :expiration_default
      t.boolean :lot_number
      t.boolean :doc_u_dose
      t.boolean :default_to_primary_plan
      t.boolean :valid_division_codes
      t.boolean :form_flags
      t.boolean :start_date
      t.boolean :post_zero_copay
      t.boolean :frequency_auto_fill
      t.boolean :anniversary_auto_fill
      t.boolean :procycle_auto_fill
      t.integer :print_monograph
      t.boolean :log_dur_results
      t.integer :require_hippa_privacy_notice
      t.integer :print_medication_guide
      t.boolean :print_medication_administration_form
      t.boolean :print_physician_order_form
      t.boolean :print_treatment_form
      t.boolean :print_delivery_receipt
      t.string :medication_administration_form, limit: 12
      t.string :physician_orders_form, limit: 12
      t.string :treatment_form, limit: 12
      t.integer :print_order
      t.boolean :print_pass_times
      t.boolean :print_other_allergy
      t.string :med_administration_routine_heading, limit: 12
      t.string :med_administration_prn_heading, limit: 12
      t.string :treatment_heading, limit: 12
      t.boolean :print_fill_date
      t.boolean :print_original_date
      t.boolean :print_in_frequency_order
      t.boolean :require_rx_copy_in_facility
      t.boolean :expand_sig_codes
      t.text :standing_orders
      t.integer :type_of_facility

      t.timestamps null: false
    end
  end
end
