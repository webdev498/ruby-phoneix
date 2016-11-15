class CreateClaimCoupons < ActiveRecord::Migration
  def change
    create_table :claim_coupons do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :plan_id_code
      t.string :coupon_number, limit: 15
      t.integer :coupon_type
      t.decimal :coupon_amount, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
