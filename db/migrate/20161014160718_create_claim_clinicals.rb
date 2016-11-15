class CreateClaimClinicals < ActiveRecord::Migration
  def change
    create_table :claim_clinicals do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.references :dispense, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :plan_id_code
      t.integer :diagnosis_counter
      t.integer :diagnosis_code_qualifier
      t.string :diagnosis_code, limit: 15
      t.integer :clinical_counter
      t.date :clinical_date
      t.string :clinical_dimension, limit: 2
      t.integer :clinical_time, limit: 4
      t.string :clinical_unit, limit: 2
      t.string :clinical_value, limit: 15

      t.timestamps null: false
    end
  end
end
