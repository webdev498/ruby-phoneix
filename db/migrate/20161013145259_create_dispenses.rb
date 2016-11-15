class CreateDispenses < ActiveRecord::Migration
  def change
    create_table :dispenses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.references :prescription, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.references :rx_signature, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :fill_number
      t.integer :legacy_customer_id_number
      t.timestamp :fill_time
      t.integer :legacy_item_id_number
      t.integer :refill_type
      t.integer :status
      t.boolean :split_bill_rx
      t.boolean :billing_complete
      t.string :pharmacist_initials, limit: 4
      t.string :technician_initials, limit: 4
      t.decimal :quantity, precision: 9, scale: 3
      t.integer :days_supply
      t.string :delivery_route, limit: 2
      t.string :lot_number, array: true
      t.string :serial_number, array: true
      t.date :discard_date
      t.decimal :price, precision: 8, scale: 2
      t.decimal :usual_customary_price, precision: 8, scale: 2
      t.decimal :base_cost, precision: 8, scale: 2
      t.decimal :acquisition_cost, precision: 8, scale: 2
      t.decimal :fee, precision: 6, scale: 2
      t.decimal :discount, precision: 6, scale: 2
      t.decimal :tax, precision: 6, scale: 2
      t.decimal :ancillary_fee, precision: 6, scale: 2
      t.decimal :professional_service_fee, precision: 6, scale: 2
      t.integer :cost_basis
      t.integer :other_coverage_code
      t.decimal :other_amount, precision: 6, scale: 2
      t.string :other_amount_type, limit: 2
      t.integer :reason_for_delay
      t.integer :denial_override_code
      t.integer :partial_fill_status
      t.integer :reported_to_pmp

      t.timestamps null: false
    end
  end
end
