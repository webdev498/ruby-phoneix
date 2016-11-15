class NcpdpD0_ClaimBuilder

  # include ActiveModel::Model
	# include ActiveModel::AttributeMethods
	# include ActiveModel::Validations
	# include ActiveModel::Conversion
	# include ActiveModel::Naming


  REQUIRED = true
  MANDATORY = true
  OPTIONAL = !MANDATORY


  # def initialize prescription_id
  #   @prescription = Prescription.find prescription_id
  # end


  def build_claim_request_for prescription_id
    @prescription = Prescription.find prescription_id
    claimRequestString = ""
    NcpdpD0_ClaimRequest.ncpdpD0.each do |segment|
      claimRequestString << segment.to_s_from( @prescription )
    end
    claimRequestString
  end


  def build_claim_request_patient_segment_for prescription_id
    @prescription = Prescription.find prescription_id
    NcpdpD0_ClaimRequest.patientSegment.to_s_from( @prescription.customer )
  end


  def self.insuranceSegment
      @@InsuranceSegment
  end

  def self.patientSegment
      @@PatientSegment
  end


  def self.claimSegment
      @@PClaimSegment
  end

  # find the field definition
  def field_definition_for fieldId
  end

  protected
    def buildSegment
    end

  protected
    def applyModel
    end

end
