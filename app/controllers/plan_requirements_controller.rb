class PlanRequirementsController < ApplicationController
  before_action :set_plan_requirement, only: [:show, :edit, :update, :destroy]

  # GET /plan_requirements
  # GET /plan_requirements.json
  def index
    @plan_requirements = PlanRequirement.all
  end

  # GET /plan_requirements/1
  # GET /plan_requirements/1.json
  def show
  end

  # GET /plan_requirements/new
  def new
    @plan_requirement = PlanRequirement.new
  end

  # GET /plan_requirements/1/edit
  def edit
  end

  # POST /plan_requirements
  # POST /plan_requirements.json
  def create

    plan_requirement_params[:provider_id_qualifier] = plan_requirement_params[:provider_id_qualifier].to_i

    @plan_requirement = PlanRequirement.new(plan_requirement_params)

    respond_to do |format|
      if @plan_requirement.save
        format.html { redirect_to @plan_requirement, notice: 'Plan requirement was successfully created.' }
        format.json { render :show, status: :created, location: @plan_requirement }
      else
        format.html { render :new }
        format.json { render json: @plan_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plan_requirements/1
  # PATCH/PUT /plan_requirements/1.json
  def update

    plan_requirement_params[:provider_id_qualifier] = plan_requirement_params[:provider_id_qualifier].to_i

    respond_to do |format|
      if @plan_requirement.update(plan_requirement_params)
        format.html { redirect_to @plan_requirement, notice: 'Plan requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan_requirement }
      else
        format.html { render :edit }
        format.json { render json: @plan_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plan_requirements/1
  # DELETE /plan_requirements/1.json
  def destroy
    @plan_requirement.destroy
    respond_to do |format|
      format.html { redirect_to plan_requirements_url, notice: 'Plan requirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan_requirement
      @plan_requirement = PlanRequirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_requirement_params
      params.require(:plan_requirement).permit(:dept_number, :rna_plan_id_code, :bin_number, :processor_control_number, :version_number, :software_id, :provider_id_qualifier, :provider_id_number, :otc_ingredients_on_compound, :bundle_claims, :copay_assist_plan, :use_facility_segment, :use_prescriber_segment, :use_prior_authorization_segment, :use_coordination_of_benefits_segment, :use_compound_segment, :use_drug_utilization_review_segment, :use_clinical_segment, :use_coupon_segment, :use_workers_compensation_segment, :patient_birthdate, :patient_gender, :patient_first_name, :patient_last_name, :patient_address, :patient_city, :patient_state, :patient_zip_code, :patient_phone, :patient_residence_code, :patient_location_code, :patient_smoker, :patient_pregnant, :patient_email, :patient_employer_id, :patient_universal_id, :cardholder_id_number, :group_id_number, :plan_id_number, :person_code, :cardholder_first_name, :cardholder_last_name, :relationship_code, :home_plan, :eligibility_code, :facility_id_number, :medigap_indicator, :assignment_indicator, :partd_indicator, :medicaid_indicator, :medicaid_id_number, :fill_number, :days_supply, :dispense_as_written_code, :quantity_dispensed, :date_written, :refills_prescribed, :origin_code, :compound_indicator, :compound_type, :product_id_number_qualifier, :product_id_number, :route_of_administration, :pharmacy_type, :denial_override_code, :denial_override_count, :quantity_prescribed, :other_coverage, :regular_prior_authorization, :regular_prior_authorization_type, :dispense_status, :intended_quantity, :intended_days_supply, :level_of_service, :unit_of_measure, :unit_dose_indicator, :delay_code, :dea_blank_number, :patient_rx_assignment, :alternate_id_number, :original_product_id_number, :original_quantity_prescribed, :associated_rx_number, :associated_date, :procedure_modifier, :intermediary_type, :intermediary_authorization, :prescriber_id_number_qualifier, :prescriber_first_name, :prescriber_last_name, :prescriber_address, :prescriber_city, :prescriber_state, :prescriber_zip_code, :prescriber_phone_number, :prescriber_location, :primary_prescriber_id_qualifier, :primary_prescriber_last_name, :primary_prescriber_location, :other_payor_count, :other_payor_coverage_type, :other_payor_id_number, :other_payor_date, :other_payor_amount_paid, :other_payor_reject_count, :other_payor_reject_code, :other_payor_patient_amount_count, :other_payor_patient_amount_qualifier, :other_payor_patient_amount, :other_payor_benefit_count, :other_payor_benefit_qualifier, :other_payor_benefit_amount, :other_payor_control_number, :dur_counter, :dur_reason_code, :dur_service_code, :dur_result_code, :dur_effort_code, :dur_coagent, :base_cost, :dispensing_fee, :service_fee, :copay, :incentive_fee, :other_amount, :flat_tax_amount, :pct_tax_amount, :tax_rate, :tax_basis, :usual_customary_price, :amount_due, :basis_of_cost, :price_override, :dosage_form, :dispensing_unit, :route_of_administration, :ingredient_id_number, :ingredient_quantity_dispensed, :ingredient_cost, :ingredient_cost_basis, :ingredient_modifier_count, :ingredient_modifier, :date_of_injury, :employer_name, :employer_address, :employer_city, :employer_state, :employer_zip_code, :employer_phone, :employer_contact, :carrier_id_number, :employer_reference_id, :employer_type, :pay_to_qualifier, :pay_to_id_number, :pay_to_name, :pay_to_address, :pay_to_city, :pay_to_state, :pay_to_zip_code, :general_id_qualifier, :general_id_number, :request_type, :request_begin_date, :request_end_date, :request_basis, :representative_first_name, :representative_last_name, :representative_address, :representative_city, :representative_state, :representative_zip_code, :prior_authorization_assigned, :prior_authorization_number, :prior_authorization_prescriber, :diagnosis_count, :diagnosis_code, :clinical_count, :clinical_date, :clinical_time, :clinical_dimension, :clinical_unit, :clinical_value, :coupon_type, :coupon_number, :coupon_amount, :secondary_provider_id_qualifier, :secondary_provider_id_number)
    end
end
