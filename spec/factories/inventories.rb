FactoryGirl.define do
  factory :inventory do
    company_id 1
pharmacy_id 1
item nil
last_order_date "2016-10-14"
last_package_cost "9.99"
reorder_point "9.99"
quantity_on_order "9.99"
optimal_quantity "9.99"
supplier_id ""
supplier_order_number ""
supplier_minimum_order_quantity ""
supplier_cost ""
  end

end
