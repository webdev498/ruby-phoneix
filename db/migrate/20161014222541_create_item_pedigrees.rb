class CreateItemPedigrees < ActiveRecord::Migration
  def change
    create_table :item_pedigrees do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :item, index: true, foreign_key: true
      t.references :supplier, index: true, foreign_key: true
      t.boolean :active
      t.string :lot_number, limit: 15
      t.string :serial_number, limit: 15
      t.date :date_received
      t.decimal :quantity_received, precision: 10, scale: 3
      t.decimal :quantity_remaining, precision: 10, scale: 3

      t.timestamps null: false
    end
  end
end
