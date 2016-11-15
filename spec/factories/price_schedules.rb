FactoryGirl.define do
  factory :price_schedule do
    company_id 1
pharmacy_id 1
number 1
active false
basis 1
name "MyString"
break_type 1
qualifier 1
fee_calculation_type 1
usual_customary_calculation 1
customer_assigned_schedule 1
generic_percentage_calculation false
discounts_allowed false
cumulative false
exact_hit false
round_price false
round_to_amount "9.99"
percentage_fee_type 1
amount_fee_type 1
  end

end
