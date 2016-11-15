FactoryGirl.define do
  factory :claim_clinical do
    company_id 1
pharmacy_id 1
claim nil
dispense nil
rx_number 1
plan_id_code 1
diagnosis_counter 1
diagnosis_code_qualifier 1
diagnosis_code "MyString"
clinical_counter 1
clinical_date "2016-10-14"
clinical_dimension "MyString"
clinical_time 1
clinical_unit "MyString"
clinical_value "MyString"
  end

end
