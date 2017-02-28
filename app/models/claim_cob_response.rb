class ClaimCobResponse < ActiveRecord::Base
    
    belongs_to :claim

    enum payor_id_qualifier: [ :other_number, :hippa_number, :bin_number, :naic_number, :medicare_carrier, :medicare, :medicaid ]
    
end
