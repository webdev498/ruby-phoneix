FactoryGirl.define do
  factory :claim_coupon do
    company_id 1
pharmacy_id 1
claim nil
rx_number 1
plan_id_code 1
coupon_number "MyString"
coupon_type 1
coupon_amount "9.99"
  end

end
