FactoryGirl.define do
  factory :account_posting do
    company_id 1
pharmacy_id 1
account nil
master_account_number 1
account_number 1
post_date "2016-10-11"
post_ticket 1
post_ticket_sequence 1
post_payor_id 1
post_source 1
post_type 1
post_description "MyString"
post_medical_amount "9.99"
post_non_medical_amount "9.99"
post_tax_amount "9.99"
  end

end
