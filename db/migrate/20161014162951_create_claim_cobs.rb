class CreateClaimCobs < ActiveRecord::Migration
  def change
    create_table :claim_cobs do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :plan_id_code
      t.integer :rx_number
      t.integer :fill_number
      t.integer :payor_count
      t.string :payor_coverage_type, limit: 2
      t.integer :payor_id_qualifier
      t.string :payor_id, limit: 10
      t.date :payor_date
      t.integer :payor_reject_count
      t.string :payor_reject_code, array: true
      t.integer :payor_paid_count
      t.string :payor_paid_qualifier, limit: 2
      t.decimal :payor_amount_paid, precision: 9, scale: 2
      t.integer :patient_amount_qualifier
      t.decimal :patient_amount, precision: 9, scale: 2
      t.string :benefit_qualifier, limit: 2
      t.decimal :benefit_amount, precision: 9, scale: 2
      t.string :control_number, limit: 30

      t.timestamps null: false
    end
  end
end
