class Print

  include ActiveModel::Model

  def initialize( params = nil )
  	@params = params
  	# lp_print = Print.new( )
  end

  # def show_pdf
  # 	my_pdf = Label.to_pdf
  # end
  # If false, return the pdf inline, else return as an attachment
  def attachment( bool )
  	return ( bool.nil? || bool == false ) ? 'inline' : 'attachment'
  end

end
