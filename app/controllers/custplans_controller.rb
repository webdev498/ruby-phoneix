class CustplansController < ApplicationController
  before_action :set_custplan, only: [:show, :edit, :update, :destroy]

  # GET /custplans
  # GET /custplans.json
  def index
    @custplans = Custplan.all
  end

  # GET /custplans/1
  # GET /custplans/1.json
  def show
  end

  # GET /custplans/new
  def new
    @custplan = Custplan.new
  end

  # GET /custplans/1/edit
  def edit
  end

  # POST /custplans
  # POST /custplans.json
  def create
    @custplan = Custplan.new(custplan_params)

    respond_to do |format|
      if @custplan.save
        format.html { redirect_to @custplan, notice: 'Custplan was successfully created.' }
        format.json { render :show, status: :created, location: @custplan }
      else
        format.html { render :new }
        format.json { render json: @custplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custplans/1
  # PATCH/PUT /custplans/1.json
  def update
    respond_to do |format|
      if @custplan.update(custplan_params)
        format.html { redirect_to @custplan, notice: 'Custplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @custplan }
      else
        format.html { render :edit }
        format.json { render json: @custplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custplans/1
  # DELETE /custplans/1.json
  def destroy
    @custplan.destroy
    respond_to do |format|
      format.html { redirect_to custplans_url, notice: 'Custplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custplan
      @custplan = Custplan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custplan_params
      params.require(:custplan).permit(:dept_number, :rna_customer_id_number, :rna_plan_id_code, :sequence_number, :plan_type, :plan_abb_name, :active_flag, :plan_start_date, :plan_end_date, :plan_prior_authorization, :plan_prior_authorization_type, :plan_first_name, :plan_last_name, :plan_card_number, :plan_number, :plan_group_number, :plan_person_code, :plan_relationship_code, :plan_other_insurance_code, :plan_home_plan, :plan_eligibility_code, :plan_employee_id, :plan_universal_id, :plan_universal_id_type, :plan_cardholder_first_name, :plan_cardholder_last_name, :plan_facility_id, :plan_location_code, :plan_limit_of_rx, :plan_current_number_rx, :plan_current_amount, :plan_ytd_number_rx, :plan_ytd_amount, :plan_date_of_injury, :plan_medigap_id, :plan_state_medicaid, :plan_medicaid_id, :plan_employer_name, :plan_employer_address, :plan_employer_city, :plan_employer_state, :plan_employer_zip_code, :plan_employer_phone, :plan_employer_contact, :plan_employer_carrier_id, :plan_employer_claim_number, :plan_carrier_id_number, :plan_assist_drug_ndc, :plan_brand_name_copay, :plan_generic_drug_copay, :plan_brand_name_copay_pct, :plan_generic_copay_pct, :plan_ytd_copay, :plan_ytd_copay_limit, :plan_fixed_copay, :plan_higher_copay, :plan_begin_range)
    end
end
