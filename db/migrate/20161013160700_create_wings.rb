class CreateWings < ActiveRecord::Migration
  def change
    create_table :wings do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :facility, index: true, foreign_key: true
      t.integer :facility_options_id
      t.integer :pass_times_id
      t.boolean :active
      t.string :name, limit: 30
      t.string :contact, limit: 30

      t.timestamps null: false
    end
  end
end
