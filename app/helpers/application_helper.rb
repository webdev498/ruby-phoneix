module ApplicationHelper

	# helper to convert boolean to yes or no
	def yesno( aboolean )
		aboolean ? "Yes" : "No"
	end
	def option_helper(cond,value,&block)
		attributes = {}
		if(cond == false)
			attributes[ 'style' ]='display:none'
		end
		attributes['value'] = value;
		content_tag(:option, yield , attributes)
	end
end
