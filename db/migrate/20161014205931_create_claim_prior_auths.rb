class CreateClaimPriorAuths < ActiveRecord::Migration
  def change
    create_table :claim_prior_auths do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :plan_id_code
      t.integer :authorization_number, limit: 8
      t.integer :authorization_basis
      t.date :effective_date
      t.date :expiration_date
      t.integer :request_type
      t.string :representative_first_name, limit: 12
      t.string :representative_last_name, limit: 15
      t.string :representative_address, limit: 30
      t.string :representative_city, limit: 30
      t.string :representative_state, limit: 2
      t.string :representative_zip_code, limit: 10
      t.text :supporting_text
      t.decimal :response_amount_authorized, precision: 8, scale: 2
      t.date :response_effective_date
      t.date :response_expiration_date
      t.integer :refills_authorized
      t.date :response_processed_date
      t.decimal :quantity_authorized, precision: 10, scale: 3
      t.decimal :quantity_accumulated, precision: 10, scale: 3

      t.timestamps null: false
    end
  end
end
