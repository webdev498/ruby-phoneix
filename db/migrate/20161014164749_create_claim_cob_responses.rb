class CreateClaimCobResponses < ActiveRecord::Migration
  def change
    create_table :claim_cob_responses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :plan_id_code
      t.integer :rx_number
      t.integer :fill_number
      t.integer :other_payor_count
      t.string :payor_coverage_type, limit: 2
      t.integer :payor_id_qualifier
      t.string :payor_id, limit: 10
      t.string :payor_processor_control_number, limit: 10
      t.string :payor_card_id_number, limit: 20
      t.string :payor_group_number, limit: 18
      t.string :payor_person_code, limit: 2
      t.string :payor_phone_number, limit: 18
      t.string :payor_relation_code, limit: 1
      t.date :payor_effective_date
      t.date :payor_expiration_date
      t.integer :payor_benefit_count
      t.string :payor_benefit_qualifier, limit: 2
      t.decimal :payor_benefit_amount, precision: 8, scale: 2
      t.decimal :payor_coverage_gap, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
