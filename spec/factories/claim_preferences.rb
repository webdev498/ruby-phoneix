FactoryGirl.define do
  factory :claim_preference do
    company_id 1
pharmacy_id 1
claim nil
plan_id_code 1
rx_number 1
fill_number 1
product_count 1
product_copay_incentive "9.99"
product_incentive "9.99"
product_name "MyString"
product_id_number "MyString"
product_qualifier 1
  end

end
