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

    customer_plan_params[:plan_type] = customer_plan_params[:allergy_type].to_i
    customer_plan_params[:prior_authorization_type] = customer_plan_params[:prior_authorization_type].to_i
    customer_plan_params[:relationship_code] = customer_plan_params[:relationship_code].to_i
    customer_plan_params[:accounting_method] = customer_plan_params[:accounting_method].to_i
    customer_plan_params[:payor_type] = customer_plan_params[:payor_type].to_i

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

    customer_plan_params[:plan_type] = customer_plan_params[:allergy_type].to_i
    customer_plan_params[:prior_authorization_type] = customer_plan_params[:prior_authorization_type].to_i
    customer_plan_params[:relationship_code] = customer_plan_params[:relationship_code].to_i
    customer_plan_params[:accounting_method] = customer_plan_params[:accounting_method].to_i
    customer_plan_params[:payor_type] = customer_plan_params[:payor_type].to_i

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
      params.require(:customer_plan).permit(:company_id, :pharmacy_id, :customer_id, :legacy_customer_id_number, :plan_id_code, :sequence_number, :plan_type, :plan_abb_name, :active, :effective_date, :expiration_date, :prior_authorization, :prior_authorization_type, :first_name, :last_name, :card_number, :plan_number, :group_number, :person_code, :relationship_code, :other_insurance_code, :pending, :home_plan, :eligibility_code, :employee_id_number, :universal_id_number, :universal_id_type, :cardholder_first_name, :cardholder_last_name, :facility_id_number, :location_code, :limit_of_rx, :current_number_rx, :current_amount, :ytd_number_rx, :ytd_amount, :date_of_injury, :medigap_id_number, :state_medicaid, :medicaid_id_number, :employer_name, :employer_address, :employer_city, :employer_state, :employer_zip_code, :employer_phone, :employer_contact, :employer_carrier_id_number, :employer_claim_number, :carrier_id_number, :assist_drug_ndc, :brand_name_copay, :generic_drug_copay, :brand_name_copay_pct, :generic_copay_pct, :ytd_copay, :ytd_copay_limit, :fixed_copay, :higher_copay, :begin_range, :account_number, :master_account_number, :accounting_method, :payor_type, :—force)
    end
end
