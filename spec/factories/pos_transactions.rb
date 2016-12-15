
FactoryGirl.define do
  factory :pos_transaction do
    company_id 1
pharmacy_id 1
transaction_date "2016-10-11"
ticket_number 1
legacy_customer_id_number 1
initials "MyString"
register_number 1
account_number 1
posted_flag false
any_flex_spending_items false
number_items 1
primary_payment_method "MyString"
primary_payment_amount "9.99"
secondary_payment_method "MyString"
secondary_payment_amount "9.99"
total_amount "9.99"
total_tax "9.99"
medical_amount "9.99"
medical_tax "9.99"
medical_total "9.99"
non_medical_amount "9.99"
non_medical_tax "9.99"
non_medical_total "9.99"
  end

end
