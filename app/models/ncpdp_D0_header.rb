class NcpdpD0_Header < NcpdpD0_ClaimBuilder

  # Abstract class to  Request and Rebill

  # field arguments:   elementId, mandatory, name, datatype, pic=[], value=nil

  # Abstract calss - Claim Bill

  # Header
  @@HeaderSegment = NcpdpD0_Segment.new( REQUIRED,
    NcpdpD0_Field.new('101-A1', MANDATORY, 'Segment ID',            'A', [2,0], value: '04' ),
    NcpdpD0_Field.new('102-A2', MANDATORY, 'Cardholder ID',         'A', [20,0] ),
    NcpdpD0_Field.new('103-A3', MANDATORY, 'Cardholder First Name', 'A', [12,0] ),
    NcpdpD0_Field.new('104-A4', MANDATORY, 'Cardholder Last Name',  'A', [15,0] ),
    NcpdpD0_Field.new('109-A9', MANDATORY, 'GROUP',              'A', [15,0] ),
    NcpdpD0_Field.new('202-B2', MANDATORY, 'GROUP',              'A', [15,0] ),
    NcpdpD0_Field.new('201-B1', MANDATORY, 'GROUP',              'A', [15,0] ),
    NcpdpD0_Field.new('401-D1', MANDATORY, 'GROUP',              'A', [15,0] ),
    NcpdpD0_Field.new('110-AK', MANDATORY, 'GROUP',              'A', [15,0] )
    )

  def self.ncpdpD0
      nil
  end

  def self.headerSegment
    @@HeaderSegment
  end

end
