class Plan < ActiveRecord::Base
  has_one :plan_requirement
  has_many :claims

  enum copay_type: [ :'No Copay', :Online, :Fixed, :'Fixed Pct', :'Brand Generic', :'Brand Generic Pct', :'Fixed Until Limit', :'Fixed After Limit', :'Pharmacist Entry' ]
  enum support_split_billing: [ :'No Split Billing', :'Copay Eligible', :'Plan Accepts', :'Copay and Plan Supported' ]
  enum plan_type: [ :insurance, :workersComp, :charge ]
  enum payor_type: [ :'standard Insurance', :medicaid, :'medicare Part D', :cash ]

  def self.search_by_plan_name sourceString

    #Plan.where("insurance_plan_name like :desc", :desc=>"#{sourceString}%")
    Plan.select("plans.id, plans.plan_id_code,plans.bin_number, plans.insurance_plan_name , plans.processor_control_number,plans.plan_type,plans.active").where("insurance_plan_name like '#{sourceString}%'").first(9)
  end

  def self.search_by_partial sourceString
    Plan.find_by_sql("select  plans.id ,plans.plan_id_code,plans.bin_number,plans.insurance_plan_name, plans.processor_control_number,plans.plan_type,plans.active from plans where plans.bin_number = #{sourceString}").first(9)
  end
end
