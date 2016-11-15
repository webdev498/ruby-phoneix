class CreateCustomerAllergies < ActiveRecord::Migration
  def change
    create_table :customer_allergies do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.integer :legacy_customer_id_number
      t.integer :allergy_code
      t.integer :allergy_type
      t.string :allergy_description, limit: 50

      t.timestamps null: false
    end
  end
end
