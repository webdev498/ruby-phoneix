class CreateBeds < ActiveRecord::Migration
  def change
    create_table :beds do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :facility, index: true, foreign_key: true
      t.references :wing, index: true, foreign_key: true
      t.references :residency, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.integer :legacy_customer_id_number
      t.boolean :active
      t.integer :pass_order
      t.string :bed, limit: 8
      t.string :bed_type, limit: 20
      t.date :occupancy_date

      t.timestamps null: false
    end
  end
end
