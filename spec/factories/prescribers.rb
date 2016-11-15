FactoryGirl.define do
  factory :prescriber do
    company_id 1
pharmacy_id 1
person_image nil
legacy_prescriber_id_number 1
last_name "MyString"
first_name "MyString"
middle_name "MyString"
dea_number "MyString"
npi_number 1
surescripts_erx_id_number 1
emdeon_erx_id_number "MyString"
active false
participates_in_340b false
location_code "MyString"
requires_supervisor false
address1 "MyString"
address2 "MyString"
city "MyString"
state "MyString"
zip_code "MyString"
specialty "MyString"
notes "MyText"
memo "MyString"
group_code "MyString"
sig_default false
erx_eligibility false
remote_access false
facility_number 1
allowed_to_prescribe_narcotics false
allowed_to_prescribe_controlled false
alternate_id1_qualifier 1
alternate_id1 "MyString"
alternate_id1_source 1
alternate_id2_qualifier 1
alternate_id2 "MyString"
alternate_id2_source 1
alternate_id3_qualifier 1
alternate_id3 "MyString"
alternate_id3_source 1
alternate_id4_qualifier 1
alternate_id4 "MyString"
alternate_id4_source 1
  end

end
