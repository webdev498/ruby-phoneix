class CreateFacilityOrders < ActiveRecord::Migration
  def change
    create_table :facility_orders do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.integer :facility_id
      t.integer :wing_id
      t.boolean :active_flag
      t.string :code, limit: 8
      t.text :order_description

      t.timestamps null: false
    end
  end
end
