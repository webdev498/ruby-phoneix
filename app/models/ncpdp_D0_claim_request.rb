class NcpdpD0_ClaimRequest < NcpdpD0_ClaimBill


  # Claim Request

#  @@NCPDP_D0_ClaimRequest = [
  @@NCPDP_D0_ClaimRequest = [
    @@InsuranceSegment,
    @@PatientSegment,
    @@ClaimSegment,
    @@PricingSegment,
    @@PrescriberSegment,
    @@CobSegment,
    @@DurSegment,
    @@CompoundSegment,
    @@ClinicalSegment
  ]

  def self.ncpdpD0
      @@NCPDP_D0_ClaimRequest
  end

end
