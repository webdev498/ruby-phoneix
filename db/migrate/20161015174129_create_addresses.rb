class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.integer :customer_id
      t.integer :prescriber_id
      t.integer :kind
      t.integer :use
      t.integer :rank
      t.string :street
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.boolean :active

      t.timestamps null: false
    end
  end
end
