FactoryGirl.define do
  factory :pos_payment_method do
    company_id 1
pharmacy_id 1
payment_method_code "MyString"
payment_method_description "MyString"
payment_method_processing_pct "9.99"
merchant_id_number "MyString"
  end

end
