class CreateClaimPreferences < ActiveRecord::Migration
  def change
    create_table :claim_preferences do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :plan_id_code
      t.integer :rx_number
      t.integer :fill_number
      t.integer :product_count, limit: 1
      t.decimal :product_copay_incentive, precision: 8, scale: 2
      t.decimal :product_incentive, precision: 8, scale: 2
      t.string :product_name, limit: 40
      t.string :product_id_number, limit: 19
      t.integer :product_qualifier

      t.timestamps null: false
    end
  end
end
