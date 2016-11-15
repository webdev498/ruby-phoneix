class CreateDispenseCompounds < ActiveRecord::Migration
  def change
    create_table :dispense_compounds do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :dispense, index: true, foreign_key: true
      t.integer :rx_number
      t.integer :fill_number
      t.integer :number_rx_ingredients
      t.integer :number_non_rx_ingedients
      t.decimal :total_base_cost, precision: 8, scale: 2
      t.decimal :total_acquisition_cost, precision: 8, scale: 2
      t.integer :dosage_form
      t.integer :dispensing_unit
      t.string :route, limit: 11
      t.integer :therapy_type
      t.integer :level_of_effort

      t.timestamps null: false
    end
  end
end
