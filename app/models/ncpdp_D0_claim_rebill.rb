class NcpdpD0_ClaimRebill < NcpdpD0_ClaimBill

  # Rebill transaction is mostly the same as Request transaction

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil

  # Claim Rebill

  @@NCPDP_D0_ClaimRebill = [
    @@InsuranceSegment,
    @@PatientSegment
    # @@ClaimSegment
    # @@PricingSegment,
    # @@PrescriberSegment,
    # @@CobSegment,
    # @@DurSegment,
    # @@CompoundSegment,
    # @@ClinicalSegment
  ]

  def self.ncpdpD0
      @@NCPDP_D0_ClaimRebill
  end

end
