class NcpdpD0_PriorAuthorizationRequest < NcpdpD0_ClaimBuilder

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil

  # Prior Authorization Request

  # @@NCPDP_D0_PriorAuthorizationRequest = [
  #   @@PriorAuthorizationRequestSegment
  # ]
  #
  # # AM....... - Insurance
  # @@PriorAuthorizationRequestSegment = NcpdpD0_Segment.new( REQUIRED,
  #   NcpdpD0_ClaimField.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], 'NNNNNNNNN' )
  #   )


  def self.ncpdpD0
    @@NCPDP_D0_PriorAuthorizationRequest
  end


end
