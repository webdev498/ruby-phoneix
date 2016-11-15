class CreatePharmacies < ActiveRecord::Migration
  def change
    create_table :pharmacies do |t|
      t.integer :company_id
      t.boolean :active
      t.string :pharmacy_name, limit: 30
      t.string :address1, limit: 30
      t.string :address2, limit: 30
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 10
      t.integer :rna_account_number
      t.date :expiration_date
      t.integer :ncpdp_number
      t.string :dea_number, limit: 10
      t.integer :npi_number, limit: 8
      t.integer :max_sessions
      t.string :federal_tax_id_number, limit: 10
      t.boolean :rx_taxable_flag
      t.decimal :local_tax_rate, precision: 4, scale: 4
      t.decimal :state_tax_rate, precision: 4, scale: 4
      t.decimal :total_tax_rate, precision: 4, scale: 4
      t.integer :pharmacy_type
      t.integer :claimguard_counter
      t.integer :eligibility_counter
      t.integer :us_or_metric
      t.string :promotional_message, limit: 160
      t.integer :fax_number, limit: 8
      t.integer :phone_number, limit: 8
      t.string :email

      t.timestamps null: false
    end
  end
end
