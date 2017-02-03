class NcpdpD0_Field


  FIELD_SEPARATOR = "\x1C"

  # plan requirement object
  #    0 - DO NOT send on either claim or reversal
  #    1 - MUST USE ON A claim
  #    2 - MUST USE ON A reversal, but NOT on a claim
  #    3 - MUST USE ON EITER a claim or reversal

  # field
  # name
  # mandatory - NCPDP_D0 designated as mandatory -> overrides fieldControl
  # datatype - A, D, or N
  # pic => [whole,precision]
  # value - the value that is used
  # fieldControl - the field in PlanRequirement object that controls whether or not a value is sent
  # modelField - field name from the model object that maps to this ncpdpD0 field

  def initialize elementId, mandatory, name, datatype, pic, **options
    @fullId        = elementId
    @shortId       = elementId.split('-',2)[1]
    @name          = name
    @mandatory     = mandatory
    @datatype      = datatype
    @wholePartSize = pic[0]
    @decimalSize   = pic[1]
    @value         = options[:value]
    @fieldControl  = options[:fieldControl]
    @modelField    = options[:modelField]
  end


  def to_s_from modelObject

    if @modelField
      to_string( modelObject[@modelField] ) + FIELD_SEPARATOR
    else
      ""
    end
  end

  private

  # Field Formats - text below is from the NCPDP D0 specifications
  #
  #   "N" = Unsigned Numeric, always right justified, zero filled and when used for dollar fields, have default values of zeros
  #   "Z" = phx: Unsigned Numeric, always right justified, FORCED zero filled, have default values of zeros
  #
  #   "D" = Signed Numeric, sign is internal and trailing (see section Internal Representation of Overpunch Signs),
  #         zero always positive, always right justified, zero filled dollarcents amount with
  #         2 positions to the right of the implied decimal point,
  #         all other positions to the left of the implied decimal point and when used for dollar fields,
  #         have default values of zeros.
  #
  # "A/N" = Alpha/Numeric, upper case when alpha, always left justified, space filled, upper case,
  #         printable characters and default values of spaces
  #
  #  “NX” = Numeric Extended, are always right justified and zero filled, with the right most position reserved for the sign.
  #         The field must be blank when not reported. The symbol “b” indicates a “blank” or a “positive” value.
  #         The symbol “‐“ indicates a negative value. Zeros represent a valid numeric value and do not mean “null”.
  #         All decimals are implied not explicit
  #
  #   “R” = Numeric Ø‐9 with decimal point
  #         For numeric values that have a varying number of decimal positions, a decimal data element may contain an
  #         explicit decimal point and is used. This data element type is represented as “R.”
  #         The decimal point always appears if it is at any place other than the right most position. If the value is an integer
  #         (decimal point at the right most position), the decimal point should be omitted.
  #         For negative values, the leading minus sign (‐) is used. Absence of a sign indicates a positive value.
  #         The plus sign (+) should not be transmitted. Leading zeros should be suppressed unless necessary to satisfy a minimum length requirement.
  #         Trailing zeros following the decimal point should be suppressed unless necessary to indicate precision.
  #         The use of triad separators (for example, the commas in 1,ØØØ,ØØØ, ØØØ,ØØØ) is prohibited. The length of a decimal type data
  #         element does not include the decimal point. A value of 12345.67 is valid in a field defined with a maximum length of 7.
  #
  # Phoenix variation to above definitions:
  #
  #   "T" = phx: Date - Unsigned Numeric, formatted as CCYYMMDD;  CC – Century; YY – Year; MM – Month; DD – Day

  # I don't really like using the case statement; much prefer inheritance
  # but, go with the case for now
  # sprintf <-- %[flags][width][.precision]type

  def to_string value
    case @datatype
    when 'A'
      sprintf("%s"+@wholePartSize.to_s, value)
    when 'X'
      "xxxxx"
    when 'N'
      "nnnnn"
    when 'D'
      "date"
    else
        "undefined"
    end
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
