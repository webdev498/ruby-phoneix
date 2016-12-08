class Integer
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end

class CustomersController < ApplicationController

    before_action :set_customer, only: [:show, :edit, :update, :destroy]

    # ajax answer the next page for paginated Customer search

    def nextCustomers

        @searchCustomers = Customer.nextCustomers params[:start], params[:page], 9

        # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
        # remember, its not quite a standard rails approach
        #    searchTemplate = render_to_string partial: 'common/search/customer_search_modal_template', locals: { searchCustomers: @searchCustomers }, :layout => false

        # when using the technique above, the newlines (\n) have to be removed
        #    render js: "$('#customer_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

        render  template: 'common/search/js/nextSearchCustomers.js'

    end

    def search_active
      pageNumber = params[:page] ? params[:page] : 1
      perPage = 9
      customer_id = params[:customer_id]
      @searchPlans = CustomerPlan.joins("LEFT JOIN plans ON plans.plan_id_code = customer_plans.plan_id_code")
        .select('customer_plans.id,customer_plans.plan_id_code, plans.bin_number, plans.abbreviated_name, plans.plan_type')
        .where("customer_id="+customer_id.to_s + ' AND customer_plans.active = true').page(pageNumber).per(perPage).order(:sequence_number, :id)

      render template: 'common/search/js/nextSearchPrescriptionPlans.js'
    end

    def search_customer
      dbContext = Customer.select('id,first_name,last_name,birthdate,middle_name');
      if(params[:last_name] && params[:last_name] != '')
        dbContext = dbContext.where(" last_name = '" + params[:last_name] + "'")
      end
      data = dbContext.first(9)
      render  :json => data
    end

    def search
      s_val  = params[:abb_name] ? params[:abb_name] : ''
      pageNumber = params[:page] ? params[:page] : 1
      perPage = 9
      case s_val
        when /^\d{6}$/      #6 digit bin number
          @searchPlans = Plan.select("plans.plan_id_code, plans.abbreviated_name, plans.bin_number,plans.plan_type, plans.active").where("plans.bin_number = #{s_val}").page(pageNumber).per(perPage)
        else
          @searchPlans = Plan.select("plans.id, plans.plan_id_code, plans.abbreviated_name,plans.bin_number,plans.plan_type, plans.active").where("plans.abbreviated_name like '#{s_val}%'").page(pageNumber).per(perPage)
      end

      render  template: 'common/search/js/nextSearchCustomerPlans.js'
    end

    # GET /customers/1
    # GET /customers/1.json
    def show
      @sub_index = params[:sub_index]
      @tab_index = params[:tab_index]
      if @sub_index.to_i == -1
        @plan_id_code = params[:plan_id_code]
        @plan_type = Plan.where('plan_id_code=' + @plan_id_code.to_s).first.plan_type
        @plan_abb_name = Plan.where('plan_id_code=' + @plan_id_code.to_s).first.abbreviated_name
        @tab_index = Plan.plan_types[@plan_type] + 3
      end
      render :edit
    end


    # GET /customers/new
    def new
        @customer = Customer.new
    end

    # GET /customers/1/edit
    def edit

    end

  # POST /customers
  # POST /customers.json
  def create

    customerParams = params[:customer]

    # convert enums to integer equivalent
    customerParams[:gender]         = customerParams[:gender].to_i
    customerParams[:other_language] = customerParams[:other_language].to_i

    @customer = Customer.new(customer_params)

    @customer.last_name   = @customer.last_name.upcase
    @customer.first_name  = @customer.first_name.upcase
    @customer.middle_name = @customer.middle_name.upcase
    @customer.address1    = @customer.address1.upcase
    @customer.address2    = @customer.address2.upcase
    @customer.city        = @customer.city.upcase
    @customer.state       = @customer.state.upcase
    @customer.zip_code    = @customer.zip_code.upcase
    @customer.birthdate   = DateTime.strptime(params[:customer][:birthdate], '%m-%d-%Y')   if !customerParams[:birthdate].empty?
    @customer.ssn         = customerParams[:ssn].gsub!(/[\-]/, '').to_i

    # TODO: need to restrict view to 2 digits only
    customerPct = customerParams[:discount_pct].to_f
    @customer.discount_pct = customerPct > 1 ? 0 : customerPct

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update

    customerParams = params[:customer]

    # quick upcase before ... needs to be in model
    customerParams[:last_name]   = customerParams[:last_name].upcase
    customerParams[:first_name]  = customerParams[:first_name].upcase
    customerParams[:middle_name] = customerParams[:middle_name].upcase
    customerParams[:address1]    = customerParams[:address1].upcase
    customerParams[:address2]    = customerParams[:address2].upcase
    customerParams[:city]        = customerParams[:city].upcase
    customerParams[:state]       = customerParams[:state].upcase
    customerParams[:zip_code]    = customerParams[:zip_code].upcase
    customerParams[:birthdate]   = DateTime.strptime(customerParams[:birthdate], '%m-%d-%Y')    if !customerParams[:birthdate].empty?
    customerParams[:ssn].gsub!(/[\-]/, '')

    # convert enums to integer equivalent
    customerParams[:other_language] = customerParams[:other_language].to_i
    customerParams[:gender] = customerParams[:gender].to_i

    # TODO: need to restrict view to 2 digits only
    customerPct = customerParams[:discount_pct].to_f
    customerParams[:discount_pct] = customerPct > 1 ? 0 : customerPct

    respond_to do |format|
      if @customer.update_attributes(customer_params)
        @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    # @customer.destroy
    # respond_to do |format|
    #   format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:dept_number, :rna_customer_id_number, :active, :last_name, :first_name, :middle_name,
            :address1, :address2, :city, :state, :zip_code, :head_of_household_rna_id_number, :doc_u_dose, :doc_u_dose_group,
            :birthdate, :ssn, :phone_number, :alternate_address, :gender, :head_of_household_flag,
            :rna_customer_id_number, :tax_exempt, :discount_name, :discount_pct, :nursing_home_resident, :schedule_number,
            :childproof_cap, :generic_substitution, :last_rx_report_date, :pregnant, :nursing, :height, :weight,
            :other_language, :other_allergies, :notes, :terminal, :deceased_date, :needs_review, :signature_on_file,
            :hippa_signature_date, :smoker, :facility_id_number, :location_code, :residence_code,
            :reporting_group1, :reporting_group2, :reporting_group3, :diagnosis_code, :wellness, :ethnicity, :account_number,
            :memo, :special_label,:text_msg, :id,:facility_id,:preferred_contact_method,:prescriber_id,:head_of_household_name,:price_based_pricing_schedule,
            customerPlans_attributes:[:id, :company_id,:pharmacy_id,:customer_id,:legacy_customer_id_number,:plan_id_code,:sequence_number,:plan_type,:plan_abb_name,:active,:effective_date,:expiration_date,:prior_authorization,:prior_authorization_type,:first_name,:last_name,:card_number,:plan_number,:group_number,:person_code,:relationship_code,
            :other_insurance_code,:pending,:home_plan,:eligibility_code,:employee_id_number,:universal_id_number,:universal_id_type,:cardholder_first_name,:cardholder_last_name,:facility_id_number,:location_code,:limit_of_rx,:current_number_rx,:current_amount,:ytd_number_rx,:ytd_amount,:date_of_injury,
            :medigap_id_number,:state_medicaid,:medicaid_id_number,:employer_name,:employer_address,:employer_city,:employer_state,:employer_zip_code,:employer_phone,:employer_contact,:employer_carrier_id_number,:employer_claim_number,:carrier_id_number,:assist_drug_ndc,:brand_name_copay,:generic_drug_copay,
            :brand_name_copay_pct,:generic_copay_pct,:ytd_copay,:ytd_copay_limit,:fixed_copay,:higher_copay,:begin_range,:account_number,:master_account_number,:accounting_method,:payor_type])
    end
end
