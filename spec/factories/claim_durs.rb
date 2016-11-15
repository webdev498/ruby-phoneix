FactoryGirl.define do
  factory :claim_dur do
    company_id 1
pharmacy_id 1
claim nil
plan_id_code 1
rx_number 1
fill_number 1
overflow_flag false
sent_counter 1
reason_for_service "MyString"
result_code "MyString"
service_code "MyString"
level_of_effort 1
coagent_id "MyString"
coagent_qualifier "MyString"
receive_counter 1
dur_code "MyString"
dur_severity "MyString"
dur_pharmacy "MyString"
dur_date "2016-10-14"
dur_quantity "9.99"
dur_database "MyString"
dur_prescriber 1
dur_message "MyString"
  end

end
