FactoryGirl.define do
  factory :price_break do
    company_id 1
pharmacy_id 1
price_schedule nil
number 1
percent_or_amount 1
break_limit "9.99"
markup_percent 1
markup_amount "9.99"
  end

end
