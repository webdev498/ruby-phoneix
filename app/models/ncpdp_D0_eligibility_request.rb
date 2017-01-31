class NcpdpD0_EligibilityRequest < NcpdpD0_ClaimBuilder

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil



  # AM....... - Eligibility Request
  # @@CEligibilityRequest = NcpdpD0_Segment.new( REQUIRED,
  #   NcpdpD0_ClaimField.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], 'NNNNNNNNN' )
  #   )
  #
  # # Eligibility Request
  #
  # @@NCPDP_D0_EligibilityRequest = [
  #   @@CEligibilityRequest
  # ]

  def self.ncpdpD0
      @@NCPDP_D0_EligibilityRequest
  end

end
