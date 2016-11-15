FactoryGirl.define do
  factory :plan do
    company_id 1
pharmacy_id 1
plan_id_code 1
bin_number 1
processor_control_number "MyString"
insurance_plan_name "MyString"
abbreviated_name "MyString"
active false
plan_type 1
payor_type 1
print_sort_code 1
provider_number "MyString"
account_number 1
address1 "MyString"
address2 "MyString"
city "MyString"
state "MyString"
zip_code "MyString"
phone 1
fax 1
email "MyString"
extra_unit_dose_fee "9.99"
extra_ctrl_fee "9.99"
extra_narcotic_fee "9.99"
extra_delivery_fee "9.99"
extra_ancillary_fee "9.99"
patient_price_schedule_apply false
copay_type 1
adjudicate_claims false
do_discounts_apply false
support_split_billing 1
split_bill_format "MyString"
authorization_on_label false
plan_info_on_label false
submit_as_cash false
price_based_pricing_schedule ""
notes "MyText"
  end

end
