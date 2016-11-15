class ClaimClinical < ActiveRecord::Base
	belongs_to :claim
	
	enum diagnosis_code_qualifier: [ :undefined_diagnosis, :icd10, :icd9, :snomed ]
end
