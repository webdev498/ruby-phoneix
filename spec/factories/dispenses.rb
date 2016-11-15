FactoryGirl.define do
  factory :dispense do
    company_id 1
pharmacy_id 1
customer nil
prescription nil
item nil
rx_signature nil
rx_number 1
fill_number 1
legacy_customer_id_number 1
fill_time "2016-10-11 09:51:12"
legacy_item_id_number 1
refill_type 1
status 1
split_bill_rx false
billing_complete false
pharmacist_initials "MyString"
technician_initials "MyString"
quantity "9.99"
days_supply 1
delivery_route "MyString"
lot_number ""
serial_number ""
discard_date "2016-10-11"
price "9.99"
usual_customary_price "9.99"
base_cost "9.99"
acquisition_cost "9.99"
fee "9.99"
discount "9.99"
tax "9.99"
ancillary_fee "9.99"
professional_service_fee "9.99"
cost_basis 1
other_coverage_code 1
other_amount "9.99"
other_amount_type "MyString"
reason_for_delay 1
denial_override_code 1
partial_fill_status 1
reported_to_pmp 1
  end

end
