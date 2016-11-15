FactoryGirl.define do
  factory :rx_payment do
    company_id 1
pharmacy_id 1
dispense nil
rx_number 1
fill_number 1
payor_sequence 1
plan_id_code 1
amount_paid "9.99"
posted 1
billed false
  end

end
