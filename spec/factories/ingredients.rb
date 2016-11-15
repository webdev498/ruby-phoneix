FactoryGirl.define do
  factory :ingredient do
    company_id 1
pharmacy_id 1
formula nil
item nil
legacy_item_id_number 1
ndc_number 1
basis_of_cost 1
base_cost "9.99"
acquisition_cost "9.99"
quantity "9.99"
alternate_product_type "MyString"
alternate_product_code "MyString"
waste_factor "9.99"
  end

end
