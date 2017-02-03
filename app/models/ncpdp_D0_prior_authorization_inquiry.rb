class NcpdpD0_PriorAuthorizationInquiry < NcpdpD0_ClaimBuilder

  # Prior Authorization Inquiry

  # @@NCPDP_D0_PriorAuthorizationInquiry = [
  #   @@PriorAuthorizationInquirySegment
  # ]
  #
  # # AM....... - Insurance
  # @@PriorAuthorizationInquirySegment = NcpdpD0_Segment.new( REQUIRED,
  #   NcpdpD0_ClaimField.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], 'NNNNNNNNN' )
  #   )


  def self.ncpdpD0
      @@NCPDP_D0_PriorAuthorizationInquiry
  end


end
