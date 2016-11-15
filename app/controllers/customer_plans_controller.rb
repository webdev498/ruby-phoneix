class CustomerPlansController < ApplicationController
  before_action :set_customer_plan, only: [:show, :edit, :update, :destroy]

  # GET /customer_plans
  # GET /customer_plans.json
  def index
    @customer_plans = CustomerPlan.all
  end

  # GET /customer_plans/1
  # GET /customer_plans/1.json
  def show
  end

  # GET /customer_plans/new
  def new
    @customer_plan = CustomerPlan.new
  end

  # GET /customer_plans/1/edit
  def edit
  end

  # POST /customer_plans
  # POST /customer_plans.json
  def create
    @customer = Customer.find(params[:customer_id])
    @customerPlan = @customer.customerPlans.create(customer_plan_params)

    # respond_to do |format|
    #   if @customer_plan.save
    #     format.html { redirect_to @customer_plan, notice: 'Customer plan was successfully created.' }
    #     format.json { render :show, status: :created, location: @customer_plan }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @customer_plan.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /customer_plans/1
  # PATCH/PUT /customer_plans/1.json
  def update
    respond_to do |format|
      if @customer_plan.update(customer_plan_params)
        format.html { redirect_to @customer_plan, notice: 'Customer plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_plan }
      else
        format.html { render :edit }
        format.json { render json: @customer_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_plans/1
  # DELETE /customer_plans/1.json
  def destroy
    @customer_plan.destroy
    respond_to do |format|
      format.html { redirect_to customer_plans_url, notice: 'Customer plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_plan
      @customer_plan = CustomerPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_plan_params
      params.require(:customer_plan).permit(:dept_number, :rna_customer_id_number, :rna_plan_id_code, :sequence_number, :plan_type, :plan_abb_name, :active_flag, :plan_start_date, :plan_end_date, :plan_prior_authorization, :plan_prior_authorization_type, :plan_first_name, :plan_last_name, :plan_card_number, :plan_number, :plan_group_number, :plan_person_code, :plan_relationship_code, :plan_other_insurance_code, :plan_home_plan, :plan_eligibility_code, :plan_employee_id, :plan_universal_id, :plan_universal_id_type, :plan_cardholder_first_name, :plan_cardholder_last_name, :plan_facility_id, :plan_location_code, :plan_limit_of_rx, :plan_current_number_rx, :plan_current_amount, :plan_ytd_number_rx, :plan_ytd_amount, :plan_date_of_injury, :plan_medigap_id, :plan_state_medicaid, :plan_medicaid_id, :plan_employer_name, :plan_employer_address, :plan_employer_city, :plan_employer_state, :plan_employer_zip_code, :plan_employer_phone, :plan_employer_contact, :plan_employer_carrier_id, :plan_employer_claim_number, :plan_carrier_id_number, :plan_assist_drug_ndc, :plan_brand_name_copay, :plan_generic_drug_copay, :plan_brand_name_copay_pct, :plan_generic_copay_pct, :plan_ytd_copay, :plan_ytd_copay_limit, :plan_fixed_copay, :plan_higher_copay, :plan_begin_range)
    end
end
