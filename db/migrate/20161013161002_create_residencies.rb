class CreateResidencies < ActiveRecord::Migration
  def change
    create_table :residencies do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.references :facility, index: true, foreign_key: true
      t.integer :legacy_customer_id_number
      t.date :admission_date
      t.date :discharge_date
      t.string :medical_record_number, limit: 12
      t.string :level_of_care, limit: 1
      t.string :rehabilitation_potential, limit: 1
      t.date :last_review_date
      t.text :diet_orders
      t.text :lab_orders
      t.text :activity_orders
      t.text :diagnosis
      t.text :other_allergies
      t.text :non_med_orders

      t.timestamps null: false
    end
  end
end
