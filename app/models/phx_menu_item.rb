class PhxMenuItem

	attr_accessor :name, :kind, :text, :success_path, :failure_path

	def initialize ( name, kind, text, success_path = "", failure_path = "" )
		@name = name
		@kind = kind
		@text = text
		@success_path = success_path
		@failure_path = failure_path
	end

end
