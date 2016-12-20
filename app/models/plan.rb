class Plan < ActiveRecord::Base
  has_one :plan_requirement
  has_many :claims

  enum copay_type: [ :'No Copay', :Online, :Fixed, :'Fixed Pct', :'Brand Generic', :'Brand Generic Pct', :'Fixed Until Limit', :'Fixed After Limit', :'Pharmacist Entry' ]
  enum support_split_billing: [ :'No Split Billing', :'Copay Eligible', :'Plan Accepts', :'Copay and Plan Supported' ]
  enum plan_type: [ :insurance, :workersComp, :charge ]
  enum payor_type: [ :'standard Insurance', :medicaid, :'medicare Part D', :cash ]
  enum print_sort_code: [:alphabetic, :date, :rx, :cardholder_ID, :group_ID, :pharmacy]


  def self.search_plan plan_name, bin_number
    query = ''
    case plan_name
      when /^\d{6}$/      #6 digit bin number
        query += "bin_number = '#{plan_name}'"
        case bin_number
          when /^\d{6}$/
            query += "OR bin_number = '#{bin_number}'"
        end
      else
        query += "insurance_plan_name like '#{plan_name}%'"
        case bin_number
          when /^\d{6}$/
            query = "bin_number = '#{bin_number}'"
        end
    end

    select("plans.id ,plans.plan_id_code,plans.bin_number,plans.insurance_plan_name, plans.processor_control_number,plans.plan_type,plans.active").where(query)
  end
end
