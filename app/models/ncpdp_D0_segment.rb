class NcpdpD0_Segment

  # field
  # name
  # pic
  # type - A, D, or N
  def initialize required=false, *fields
    @required = required
    @fields = fields.inject([]){|seg, fld| seg << fld}
  end

  def << field
    @fields << field
  end

  def to_s_from modelObject
    claimString = ""
    @fields.each do |field|
      claimString << field.to_s_from( modelObject )
    end
    claimString
  end

  def fields
    @fields
  end

private

  # type A
  # left–justified and space filled; A–Z, 0–9, and printable characters
  def alpha
  end

  # type D
  # right–justified, zero always positive, zero filled dollar
  # – cents amount with two positions to the right of the implied decimal point,
  # all other positions to the left of the implied decimal point and have default values
  # of zeroes when used for dollar fields (sign is internal and trailing)
  def signedNumeric
  end

  # type N
  # right–justified and zero filled
  def unsignedNumeric
  end

  def pic
  end

end
