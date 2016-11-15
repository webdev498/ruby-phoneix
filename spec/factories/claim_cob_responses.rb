FactoryGirl.define do
  factory :claim_cob_response do
    company_id 1
pharmacy_id 1
claim nil
plan_id_code 1
rx_number 1
fill_number 1
other_payor_count 1
payor_coverage_type "MyString"
payor_id_qualifier 1
payor_id "MyString"
payor_processor_control_number "MyString"
payor_card_id_number "MyString"
payor_group_number "MyString"
payor_person_code "MyString"
payor_phone_number "MyString"
payor_relation_code "MyString"
payor_effective_date "2016-10-14"
payor_expiration_date "2016-10-14"
payor_benefit_count 1
payor_benefit_qualifier "MyString"
payor_benefit_amount "9.99"
payor_coverage_gap "9.99"
  end

end
