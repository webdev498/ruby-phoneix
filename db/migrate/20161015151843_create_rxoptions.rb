class CreateRxoptions < ActiveRecord::Migration
  def change
    create_table :rxoptions do |t|
      t.integer :company_id
      t.integer :pharmacy_id
      t.integer :days_until_expiration
      t.integer :cost_report_option
      t.integer :last_new_rx_number
      t.boolean :use_split_billing
      t.boolean :process_internet_claims
      t.boolean :data_collection
      t.integer :switch_type
      t.integer :erx_interface
      t.boolean :print_erx_hard_copy
      t.boolean :erx_refill_request
      t.boolean :submit_cash_rx
      t.integer :submit_cash_paytype
      t.boolean :refill_through_date
      t.boolean :enter_daily_quantity
      t.boolean :enter_expiration_date
      t.boolean :enter_lot_number
      t.boolean :enter_serialization_info
      t.boolean :enter_discard_date
      t.boolean :enter_delivery_route
      t.boolean :enter_route_of_administration
      t.boolean :manual_counseling
      t.boolean :additional_dea_documentation
      t.boolean :realtime_drug_reporting
      t.boolean :privacy_warning
      t.boolean :workflow
      t.boolean :display_rx_profile
      t.boolean :display_customer_note
      t.boolean :display_prescriber_note
      t.boolean :display_item_note
      t.boolean :display_rx_note
      t.integer :default_paytype_option
      t.boolean :allow_rx_charge_account
      t.string :label_type, limit: 2
      t.boolean :print_discount_on_label
      t.boolean :print_barcode_on_label
      t.boolean :print_barcode_on_receipt
      t.boolean :print_store_heading
      t.boolean :print_warning_labels
      t.boolean :require_date_written_entry
      t.boolean :fax_interface
      t.boolean :text_message
      t.boolean :email_messages
      t.boolean :web_portal
      t.boolean :doc_u_dose
      t.boolean :nursing_home
      t.string :ivr_interface, limit: 10
      t.string :robotic_interface, limit: 10
      t.boolean :remote_prescriber_interface
      t.boolean :remote_customer_interface
      t.boolean :customer_wellness
      t.boolean :netrx_interface
      t.boolean :prescribe_wellness_interface
      t.boolean :cover_my_meds_interface
      t.boolean :script_ability_interface
      t.integer :system_type
      t.integer :system_network_type
      t.boolean :med_tablet
      t.boolean :drug_pedigree
      t.boolean :imedicare

      t.timestamps null: false
    end
  end
end
