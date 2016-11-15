FactoryGirl.define do
  factory :pos_detail do
    company_id 1
pharmacy_id 1
pos_transaction nil
ticket_number 1
sequence_number 1
rx_number 1
fill_number 1
category "MyString"
quantity 1
item_type "MyString"
item_number "MyString"
item_description "MyString"
price "9.99"
extended_price "9.99"
tax_amount "9.99"
medical_item false
price_override false
  end

end
