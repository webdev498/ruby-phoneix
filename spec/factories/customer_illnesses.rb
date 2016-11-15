FactoryGirl.define do
  factory :customer_illness do
    company_id 1
pharmacy_id 1
customer nil
active false
scripted_calls false
disease_code "MyString"
disease_description "MyString"
mtm_program false
rem_program false
program_name "MyString"
scripted_call_dialogue "MyString"
reporting_required false
program_sponsor "MyString"
sponsor_address "MyString"
sponsor_city "MyString"
sponsor_state "MyString"
sponsor_zip_code "MyString"
  end

end
