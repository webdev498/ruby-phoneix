FactoryGirl.define do
  factory :item_pedigree do
    company_id 1
pharmacy_id 1
item nil
supplier nil
active false
lot_number "MyString"
serial_number "MyString"
date_received "2016-10-14"
quantity_received "9.99"
quantity_remaining "9.99"
  end

end
