class CreateCustomerIllnesses < ActiveRecord::Migration
  def change
    create_table :customer_illnesses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.boolean :active
      t.boolean :scripted_calls
      t.string :disease_code, limit: 20
      t.string :disease_description, limit: 40
      t.boolean :mtm_program
      t.boolean :rem_program
      t.string :program_name, limit: 20
      t.string :scripted_call_dialogue, limit: 30
      t.boolean :reporting_required
      t.string :program_sponsor, limit: 30
      t.string :sponsor_address, limit: 30
      t.string :sponsor_city, limit: 30
      t.string :sponsor_state, limit: 2
      t.string :sponsor_zip_code, limit: 10

      t.timestamps null: false
    end
  end
end
