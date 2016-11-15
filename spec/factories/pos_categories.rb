FactoryGirl.define do
  factory :pos_category do
    company_id 1
pharmacy_id 1
pos_tax nil
category_abbreviation "MyString"
category_description "MyString"
taxable false
medical false
  end

end
