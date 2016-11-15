FactoryGirl.define do
  factory :supplier do
    company_id 1
pharmacy_id 1
organization_image nil
active false
name "MyString"
address1 "MyString"
address2 "MyString"
city "MyString"
state "MyString"
zip_code "MyString"
phone 1
fax 1
email "MyString"
vendor_pharmacy_account "MyString"
login_user_name "MyString"
login_password "MyString"
website "MyString"
allow_controlled_items false
allow_narcotic_items false
order_by_number 1
retain_backorders false
x12_supported false
purchase_order_type 1
purchase_order_format 1
last_order_date "2016-10-14"
credit_limit "9.99"
  end

end
