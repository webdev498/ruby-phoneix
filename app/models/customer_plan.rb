class CustomerPlan < ActiveRecord::Base

    belongs_to :customer

    enum plan_type: [ :insurance, :workers_comp, :charge ]
    enum prior_authorization_type: [ :not_applicable, :prior_authorization, :medical_certification, :epsdt, :copay_exemption, :rx_exemption, :family_plan, :afdc, :payor_defined ]
    enum relationship_code: [ :not_used, :insured, :spouse, :child, :other ]
    enum accounting_method: [ :balance_forward, :open_item ]
    enum payor_type: [ :patient, :head_of_household, :sponsor, :master ]


    # def bin_number
    #     bin_number= Plan.where("plan_id_code = " + self.plan_id_code.to_s).first.bin_number
    #     #
    # end

    # def processor_controller
    #     processor_control_number= Plan.where("plan_id_code = " + self.plan_id_code.to_s).first.processor_control_number
    # end
end
