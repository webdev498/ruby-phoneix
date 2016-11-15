class CreateCustomerWellnesses < ActiveRecord::Migration
  def change
    create_table :customer_wellnesses do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.references :customer, index: true, foreign_key: true
      t.boolean :active
      t.boolean :scripted_calls
      t.integer :receive_messages
      t.boolean :medication_passtime_alerts
      t.boolean :illness_monitoring
      t.boolean :customer_remote_access
      t.date :last_customer_access
      t.integer :receive_newsletter
      t.integer :review_report
      t.integer :compliance_rating
      t.integer :allow_prescriber_access
      t.date :last_contact
      t.integer :last_contact_type
      t.integer :last_contact_status

      t.timestamps null: false
    end
  end
end
