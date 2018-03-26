class Search < ActiveRecord::Base
   
	attr_accessor :target
	attr_accessor :target_value

	def where_target (target_object, target_value)      

		self.target = target_object
		self.target_value = target_value

        case target_object
    		when :customer
						Customer.search_by_partial target_value
    		when :item
         		Item.search_by_partial target_value
    		when :prescriber
        		Prescriber.search_by_partial target_value
        	when :plan
        		Plan.search_by_partial target_value
      		else
    		    []
			end     
		end 
   
end
