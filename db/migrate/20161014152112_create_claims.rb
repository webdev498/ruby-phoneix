class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.references :prescription, index: true, foreign_key: true
      t.references :dispense, index: true, foreign_key: true
      t.references :plan, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :fill_number
      t.integer :plan_id_code
      t.timestamp :transmit_time
      t.integer :status
      t.integer :legacy_customer_id_number
      t.boolean :active
      t.string :version, limit: 2
      t.integer :transmission_code
      t.string :authorization_number, limit: 20
      t.boolean :exceeds_percent
      t.boolean :dur_on_file
      t.date :date_filled
      t.integer :eligibility_override
      t.integer :origin_override
      t.decimal :usual_customary_price, precision: 8, scale: 2
      t.integer :level_of_service
      t.string :primary_prescriber_dea_number, limit: 10
      t.integer :cost_basis
      t.decimal :total_submitted, precision: 8, scale: 2
      t.decimal :metric_decimal_quantity, precision: 10, scale: 3
      t.integer :product_type
      t.string :product_code, limit: 13
      t.decimal :incentive_amount, precision: 8, scale: 2
      t.decimal :cost_submitted, precision: 8, scale: 2
      t.decimal :fee_submitted, precision: 8, scale: 2
      t.integer :percentage_tax_basis_submitted
      t.decimal :tax_submitted, precision: 8, scale: 2
      t.string :communications_error_code, limit: 3
      t.string :header_response, limit: 1
      t.string :new_plan_number, limit: 8
      t.decimal :cost_paid, precision: 8, scale: 2
      t.decimal :contract_fee, precision: 8, scale: 2
      t.decimal :tax_paid, precision: 8, scale: 2
      t.decimal :total_paid, precision: 8, scale: 2
      t.decimal :accumulated_deductible, precision: 8, scale: 2
      t.decimal :deductible_left, precision: 8, scale: 2
      t.decimal :benefit_left, precision: 8, scale: 2
      t.decimal :amount_to_deductible, precision: 8, scale: 2
      t.decimal :copay_amount, precision: 8, scale: 2
      t.decimal :amount_for_product_selection, precision: 8, scale: 2
      t.decimal :exceeds_benefit_amount, precision: 8, scale: 2
      t.decimal :incentive_fee_paid, precision: 8, scale: 2
      t.decimal :service_fee_paid, precision: 8, scale: 2
      t.decimal :other_amount_fee_paid, precision: 8, scale: 2
      t.decimal :other_payor_amount_recognized, precision: 8, scale: 2
      t.decimal :amount_attributed_to_tax, precision: 8, scale: 2
      t.decimal :partial_copay_amount, precision: 8, scale: 2
      t.integer :reimbursement_basis
      t.decimal :percent_amount_tax_paid, precision: 8, scale: 2
      t.decimal :tax_rate_paid, precision: 7, scale: 4
      t.integer :tax_basis_paid
      t.string :help_desk_phone_number, limit: 18
      t.integer :approved_message_count
      t.string :approved_message_code, array: true
      t.string :network_reimbursement_id, limit: 10
      t.integer :reject_count
      t.string :reject_code, array: true
      t.integer :reject_field_submitted, array: true
      t.text :transmission_message
      t.integer :other_coverage_code
      t.integer :denial_code, array: true
      t.string :route_of_administration, limit: 11
      t.decimal :amount_processing_fee, precision: 6, scale: 2
      t.decimal :response_amount_coinsurance, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
