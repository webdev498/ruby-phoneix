class CreateSupervisingPrescribers < ActiveRecord::Migration
  def change
    create_table :supervising_prescribers do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.boolean :active
      t.integer :supervisor_id_number
      t.integer :supervisee_id_number

      t.timestamps null: false
    end
  end
end
