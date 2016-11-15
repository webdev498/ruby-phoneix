class CreateTransferPharmacies < ActiveRecord::Migration
  def change
    create_table :transfer_pharmacies do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.boolean :active
      t.string :name, limit: 30
      t.string :address1, limit: 30
      t.string :address2, limit: 30
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 10
      t.string :phone, limit: 15
      t.string :fax, limit: 15
      t.string :license, limit: 12

      t.timestamps null: false
    end
  end
end
