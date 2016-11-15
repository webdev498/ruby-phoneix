FactoryGirl.define do
  factory :dispense_compound do
    company_id 1
pharmacy_id 1
dispense nil
rx_number 1
fill_number 1
number_rx_ingredients 1
number_non_rx_ingedients 1
total_base_cost "9.99"
total_acquisition_cost "9.99"
dosage_form 1
dispensing_unit 1
route "MyString"
therapy_type 1
level_of_effort 1
  end

end
