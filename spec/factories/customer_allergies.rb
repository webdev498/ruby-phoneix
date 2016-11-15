FactoryGirl.define do
  factory :customer_allergy do
    company_id 1
pharmacy_id 1
customer nil
legacy_customer_id_number 1
allergy_code 1
allergy_type 1
allergy_description "MyString"
  end

end
