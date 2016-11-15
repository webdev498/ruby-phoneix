class CreateCustomerPlans < ActiveRecord::Migration
  def change
    create_table :customer_plans do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.integer :legacy_customer_id_number
      t.integer :plan_id_code
      t.integer :sequence_number
      t.integer :plan_type
      t.string :plan_abb_name, limit: 6
      t.boolean :active
      t.date :effective_date
      t.date :expiration_date
      t.string :prior_authorization, limit: 15
      t.integer :prior_authorization_type
      t.string :first_name, limit: 12
      t.string :last_name, limit: 15
      t.string :card_number, limit: 20
      t.string :plan_number, limit: 8
      t.string :group_number, limit: 20
      t.string :person_code, limit: 3
      t.integer :relationship_code
      t.boolean :other_insurance_code
      t.boolean :pending
      t.string :home_plan, limit: 3
      t.integer :eligibility_code
      t.string :employee_id_number, limit: 15
      t.string :universal_id_number, limit: 20
      t.string :universal_id_type, limit: 2
      t.string :cardholder_first_name, limit: 12
      t.string :cardholder_last_name, limit: 15
      t.string :facility_id_number, limit: 10
      t.integer :location_code
      t.integer :limit_of_rx
      t.integer :current_number_rx
      t.decimal :current_amount, precision: 7, scale: 2
      t.integer :ytd_number_rx
      t.decimal :ytd_amount, precision: 7, scale: 2
      t.date :date_of_injury
      t.string :medigap_id_number, limit: 20
      t.string :state_medicaid, limit: 2
      t.string :medicaid_id_number, limit: 20
      t.string :employer_name, limit: 30
      t.string :employer_address, limit: 30
      t.string :employer_city, limit: 30
      t.string :employer_state, limit: 2
      t.string :employer_zip_code, limit: 10
      t.string :employer_phone, limit: 15
      t.string :employer_contact, limit: 30
      t.string :employer_carrier_id_number, limit: 10
      t.string :employer_claim_number, limit: 30
      t.integer :carrier_id_number
      t.integer :assist_drug_ndc, limit: 8
      t.decimal :brand_name_copay, precision: 7, scale: 2
      t.decimal :generic_drug_copay, precision: 7, scale: 2
      t.decimal :brand_name_copay_pct, precision: 3, scale: 2
      t.decimal :generic_copay_pct, precision: 3, scale: 2
      t.decimal :ytd_copay, precision: 7, scale: 2
      t.decimal :ytd_copay_limit, precision: 7, scale: 2
      t.decimal :fixed_copay, precision: 7, scale: 2
      t.decimal :higher_copay, precision: 7, scale: 2
      t.decimal :begin_range, precision: 7, scale: 2
      t.integer :account_number
      t.integer :master_account_number
      t.integer :accounting_method
      t.integer :payor_type

      t.timestamps null: false
    end
  end
end
