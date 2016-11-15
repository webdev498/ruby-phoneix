class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :facility, index: true, foreign_key: true
      t.references :wing, index: true, foreign_key: true
      t.boolean :active
      t.string :room, limit: 8

      t.timestamps null: false
    end
  end
end
