class NcpdpD0_ClaimReversal < NcpdpD0_ClaimBuilder

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil

  # Claim reversal

  @@NCPDP_D0_ClaimReversal = [
    # @@NCPDP_D0_ClaimReversal
  ]

  # AM07 - Insurance
  # @@ClaimSegment = NcpdpD0_Segment.new( REQUIRED,
  #   NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], '07' )
  #   )


  def self.ncpdpD0
      @@NCPDP_D0_ClaimReversal
  end

end
