class Plan < ActiveRecord::Base

  has_one :planRequirement
  has_many :claims

  enum copay_type: [ :no_copay, :online, :fixed, :fixed_pct, :brand_generic, :brand_generic_pct, :fixed_until_limit, :fixed_after_limit, :pharmacist_entry ]
  enum support_split_billing: [ :no_split_billing, :copay_eligible, :plan_accepts, :copay_and_plan_supported ]
  enum plan_type: [ :insurance, :workers_comp, :charge, :cash ]
  enum payor_type: [ :standard_insurance, :medicaid, :medicare_part_D, :cash_capture, :cash_plan ]
  enum print_sort_code: [:alphabetic, :date, :rx, :cardholder_ID, :group_ID, :pharmacy]

 def self.search_by_plan_name sourceString

    	#Plan.where("insurance_plan_name like :desc", :desc=>"#{sourceString}%")
    	Plan.where("insurance_plan_name like '#{sourceString}%'")
    end

    def self.search_by_partial sourceString

        case sourceString
    		when /^\d{6}$/      #6 digit bin number
    		    Plan.find_by_sql("select Plans.* from Plans inner join Plan_Requirements on Plans.id = Plan_Requirements.plan_id and Plan_Requirements.bin_number = #{sourceString}")
        		#plan.planRequirement.where(bin_number: sourceString)
      		else
    		    search_by_plan_name sourceString;
    	end
    end

end
