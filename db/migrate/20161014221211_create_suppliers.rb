class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :organization_image, index: true, foreign_key: true
      t.boolean :active
      t.string :name, limit: 30
      t.string :address1, limit: 30
      t.string :address2, limit: 30
      t.string :city, limit: 30
      t.string :state, limit: 2
      t.string :zip_code, limit: 10
      t.integer :phone, limit: 8
      t.integer :fax, limit: 8
      t.string :email
      t.string :vendor_pharmacy_account, limit: 15
      t.string :login_user_name, limit: 15
      t.string :login_password
      t.string :website, limit: 60
      t.boolean :allow_controlled_items
      t.boolean :allow_narcotic_items
      t.integer :order_by_number
      t.boolean :retain_backorders
      t.boolean :x12_supported
      t.integer :purchase_order_type
      t.integer :purchase_order_format
      t.date :last_order_date
      t.decimal :credit_limit, precision: 9, scale: 2

      t.timestamps null: false
    end
  end
end
