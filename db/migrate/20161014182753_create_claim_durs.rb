class CreateClaimDurs < ActiveRecord::Migration
  def change
    create_table :claim_durs do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :claim, index: true, foreign_key: true
      t.integer :plan_id_code
      t.integer :rx_number
      t.integer :fill_number
      t.boolean :overflow_flag
      t.integer :sent_counter
      t.string :reason_for_service, limit: 2
      t.string :result_code, limit: 2
      t.string :service_code, limit: 2
      t.integer :level_of_effort, limit: 2
      t.string :coagent_id, limit: 19
      t.string :coagent_qualifier, limit: 2
      t.integer :receive_counter
      t.string :dur_code, limit: 2
      t.string :dur_severity, limit: 1
      t.string :dur_pharmacy, limit: 1
      t.date :dur_date
      t.decimal :dur_quantity, precision: 10, scale: 3
      t.string :dur_database, limit: 1
      t.integer :dur_prescriber, limit: 1
      t.string :dur_message, limit: 30

      t.timestamps null: false
    end
  end
end
