class ClaimPreference < ActiveRecord::Base
	belongs_to :claim
	
	enum product_qualifier: [ :ndc_number, :upc_number, :mfg_number, :drg_file_reference, :health_related_item, :ingredient_identifier ]
end
