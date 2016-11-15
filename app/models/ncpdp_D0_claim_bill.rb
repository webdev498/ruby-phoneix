class NcpdpD0_ClaimBill < NcpdpD0_ClaimBuilder

  # Abstract class to  Request and Rebill

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil

  # Abstract calss - Claim Bill

  # AM04 - Insurance
  @@InsuranceSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID',            'A', [2,0], value: '04' ),
    NcpdpD0_Field.new('302-C2', MANDATORY, 'Cardholder ID',         'A', [20,0] ),
    NcpdpD0_Field.new('312-CC', OPTIONAL,  'Cardholder First Name', 'A', [12,0] ),
    NcpdpD0_Field.new('313-CD', OPTIONAL,  'Cardholder Last Name',  'A', [15,0] ),
    NcpdpD0_Field.new('301-C1', OPTIONAL,  'GROUP ID',              'A', [15,0] )
    )

  # # AM01 - Patient
  @@PatientSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID',          'A', [2,0],  value: '01' ),
    NcpdpD0_Field.new('304-C4', OPTIONAL,  'Date of Birth',       'T', [8,0],  fieldControl: :patient_birthdate, modelField: :birthdate ),
    NcpdpD0_Field.new('305-CA', OPTIONAL,  'Gender',              'A', [1,0],  fieldControl: :patient_gender, modelField: :gender ),
    NcpdpD0_Field.new('310-CA', OPTIONAL,  'First Name',          'X', [12,0], fieldControl: :patient_first_name, modelField: :first_name ),
    NcpdpD0_Field.new('311-CB', OPTIONAL,  'Last Name',           'X', [15,0], fieldControl: :patient_last_name, modelField: :last_name ),
    NcpdpD0_Field.new('335-2C', OPTIONAL,  'Pregnancy Indicator', 'X', [1,0],  fieldControl: :patient_pregnant, modelField: :pregnant )
    )

  # # AM07 - Claim
  @@ClaimSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID',            'A', [2,0], value: '07' ),
    NcpdpD0_Field.new('455-EM', MANDATORY, 'Rx/Svc Ref Qualifier',  'A', [1,0], value: '1' ),
    NcpdpD0_Field.new('402-D2', MANDATORY, 'Rx/Svc Ref Number',     'N', [12,0] ),
    NcpdpD0_Field.new('436-E1', MANDATORY, 'Prod/Svc ID Qualifier', 'A', [2,0],  fieldControl: :product_id_number_qualifier, value:'03' ),
    NcpdpD0_Field.new('407-D7', MANDATORY, 'Prod/Svc ID',           'A', [19,0], fieldControl: :product_id_number ),
    NcpdpD0_Field.new('442-E7', OPTIONAL,  'Quantity Dispensed',    'N', [7,3],  fieldControl: :quantity_dispensed ),
    NcpdpD0_Field.new('403-D3', OPTIONAL,  'Fill Number',           'N', [2,0],  fieldControl: :fill_number ),
    NcpdpD0_Field.new('405-D5', OPTIONAL,  'Days Supply',           'N', [3,0],  fieldControl: :days_supply ),
    NcpdpD0_Field.new('406-D6', OPTIONAL,  'Compound Code',         'N', [1,0],  fieldControl: :compound_indicator, value:'0' ),
    NcpdpD0_Field.new('408-D8', OPTIONAL,  'Dispense as Written',   'A', [1,0],  fieldControl: :dispense_as_written_code, value: '0' ),
    NcpdpD0_Field.new('414-DE', OPTIONAL,  'Date Rx Written',       'T', [8,0],  fieldControl: :date_written ),
    NcpdpD0_Field.new('419-DJ', OPTIONAL,  'Rx Origin Code',        'N', [1,0],  fieldControl: :origin_code, value: '0' ),
    NcpdpD0_Field.new('354-NX', OPTIONAL,  'Submission Class Code Count', 'N', [1,0], value: '1' ),
    NcpdpD0_Field.new('420-DK', OPTIONAL,  'Submission Class Code',       'N', [2,0], value: '1' ),
    NcpdpD0_Field.new('308-C8', OPTIONAL,  'Other Coverage Code',         'N', [2,0], value: '08' ),
    NcpdpD0_Field.new('418-DI', OPTIONAL,  'Level of Service',            'N', [2,0], value: '00' ),
    NcpdpD0_Field.new('461-EU', OPTIONAL,  'Prior Auth Type Code',        'N', [2,0] ),
    NcpdpD0_Field.new('462-EV', OPTIONAL,  'Prior Auth Number Sent',      'N', [11,0] )
   )

  # AM11 - Pricing
  @@PricingSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '11' )
    )

  # AM03 - Prescriber
  @@PrescriberSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '03' )
    )

  # AM05 - COB
  @@CobSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '05' )
  )

  # AM08 - DUR
  @@DurSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '08' )
    )

  # AM10 - Compound
  @@CompoundSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '10' )
  )

  # AM13 - Clinical
  @@ClinicalSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('111-AM', MANDATORY, 'Segment ID', 'A', [2,0], value: '13' )
    )

  def self.ncpdpD0
      nil
  end

  def self.patientSegment
    @@PatientSegment
  end

end
