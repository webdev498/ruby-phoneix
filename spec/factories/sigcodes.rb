FactoryGirl.define do
  factory :sigcode do
    company_id 1
pharmacy_id 1
sig_code "MyString"
active false
language 1
expanded_text "MyText"
frequency 1
  end

end
