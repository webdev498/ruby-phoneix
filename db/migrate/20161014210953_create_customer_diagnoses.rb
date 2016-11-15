class CreateCustomerDiagnoses < ActiveRecord::Migration
  def change
    create_table :customer_diagnoses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.string :diagnosis_code, limit: 8
      t.string :diagnosis_description, limit: 100

      t.timestamps null: false
    end
  end
end
