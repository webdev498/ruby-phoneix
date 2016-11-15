FactoryGirl.define do
  factory :formula do
    company_id 1
pharmacy_id 1
item nil
legacy_item_id_number 1
compound_form 1
dispensing_unit 1
route_of_administration 1
total_acquisition_cost "9.99"
total_base_cost "9.99"
quantity_produced "9.99"
number_legend_ingredients 1
number_otc_ingredients 1
level_of_effort_code 1
instructions "MyText"
  end

end
