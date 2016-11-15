FactoryGirl.define do
  factory :residency do
    company_id 1
pharmacy_id 1
customer nil
facility nil
legacy_customer_id_number 1
admission_date "2016-10-13"
discharge_date "2016-10-13"
medical_record_number "MyString"
level_of_care "MyString"
rehabilitation_potential "MyString"
last_review_date "2016-10-13"
diet_orders "MyText"
lab_orders "MyText"
activity_orders "MyText"
diagnosis "MyText"
other_allergies "MyText"
non_med_orders "MyText"
  end

end
