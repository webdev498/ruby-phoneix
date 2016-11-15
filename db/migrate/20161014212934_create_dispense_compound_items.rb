class CreateDispenseCompoundItems < ActiveRecord::Migration
  def change
    create_table :dispense_compound_items do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :dispense_compound, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :fill_number
      t.integer :legacy_item_id_number
      t.string :legend_drug
      t.integer :ndc_number, limit: 8
      t.integer :basis_of_cost
      t.string :alternate_product_type, limit: 1
      t.string :alternate_product_code, limit: 13
      t.decimal :quantity_dispensed, precision: 9, scale: 3
      t.decimal :base_cost, precision: 8, scale: 2
      t.decimal :acquistion_cost, precision: 8, scale: 2
      t.string :lot_number, array: true
      t.string :serial_number, array: true

      t.timestamps null: false
    end
  end
end
