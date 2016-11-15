class LabelParams

  # These are the only parameters that are needed for any label
  # We use them to grab everything else from DB tables
  attr_accessor :rx_number, :fill_num, :label_count

  def initialize( rx_number = 0, fill_num = 0, label_count = 0 )
  	@rx_number   = rx_number
  	@fill_num    = fill_num
    @label_count = label_count
  end

end
