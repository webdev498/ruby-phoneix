FactoryGirl.define do
  factory :claim_prior_auth do
    company_id 1
pharmacy_id 1
claim nil
rx_number 1
plan_id_code 1
authorization_number 1
authorization_basis 1
effective_date "2016-10-14"
expiration_date "2016-10-14"
request_type 1
representative_first_name "MyString"
representative_last_name "MyString"
representative_address "MyString"
representative_city "MyString"
representative_state "MyString"
representative_zip_code "MyString"
supporting_text "MyText"
response_amount_authorized "9.99"
response_effective_date "2016-10-14"
response_expiration_date "2016-10-14"
refills_authorized 1
response_processed_date "2016-10-14"
quantity_authorized "9.99"
quantity_accumulated "9.99"
  end

end
