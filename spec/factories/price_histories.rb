FactoryGirl.define do
  factory :price_history do
    company_id 1
pharmacy_id 1
item nil
employee nil
mode "MyString"
mechanism 1
source 1
element_changed 1
old_price "9.99"
new_price "9.99"
  end

end
