FactoryGirl.define do
  factory :customer_wellness do
    company_id 1
pharmacy_id 1
customer nil
active false
scripted_calls false
receive_messages 1
medication_passtime_alerts false
illness_monitoring false
customer_remote_access false
last_customer_access "2016-10-14"
receive_newsletter 1
review_report 1
compliance_rating 1
allow_prescriber_access 1
last_contact "2016-10-14"
last_contact_type 1
last_contact_status 1
  end

end
