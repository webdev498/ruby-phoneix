class Plan < ActiveRecord::Base
  has_one :plan_requirement
  has_many :claims

  enum copay_type: [ :no_copay, :online, :fixed, :fixed_pct, :brand_generic, :brand_generic_pct, :fixed_until_limit, :fixed_after_limit, :pharmacist_entry ]
  enum support_split_billing: [ :no_split_billing, :copay_eligible, :plan_accepts, :copay_and_plan_supported ]
  enum plan_type: [ :insurance, :workers_comp, :charge ]
  enum payor_type: [ :standard_insurance, :medicaid, :medicare_part_D, :cash_capture, :cash_plan ]
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
