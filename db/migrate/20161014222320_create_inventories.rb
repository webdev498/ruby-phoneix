class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :item, index: true, foreign_key: true
      t.date :last_order_date
      t.decimal :last_package_cost, precision: 9, scale: 2
      t.decimal :reorder_point, precision: 10, scale: 3
      t.decimal :quantity_on_order, precision: 10, scale: 3
      t.decimal :optimal_quantity, precision: 10, scale: 3
      t.integer :supplier_id, array: true
      t.string :supplier_order_number, array: true
      t.decimal :supplier_minimum_order_quantity, array: true
      t.decimal :supplier_cost, array: true

      t.timestamps null: false
    end
  end
end
