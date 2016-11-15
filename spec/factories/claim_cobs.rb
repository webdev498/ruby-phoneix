FactoryGirl.define do
  factory :claim_cob do
    company_id 1
pharmacy_id 1
claim nil
plan_id_code 1
rx_number 1
fill_number 1
payor_count 1
payor_coverage_type "MyString"
payor_id_qualifier 1
payor_id "MyString"
payor_date "2016-10-14"
payor_reject_count 1
payor_reject_code ""
payor_paid_count 1
payor_paid_qualifier "MyString"
payor_amount_paid "9.99"
patient_amount_qualifier 1
patient_amount "9.99"
benefit_qualifier "MyString"
benefit_amount "9.99"
control_number "MyString"
  end

end
