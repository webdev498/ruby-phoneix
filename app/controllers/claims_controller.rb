# RNA Holdings, LLC - COPYRIGHT and INTELLECTUAL PROPERTY NOTICE:
# This source code contains copyrighted material and other confidential and proprietary information
# that is wholly owned by RNA Holdings, LLC d/b/a Mobile MedSoft, LLC.  All rights reserved.

class ClaimsController < ApplicationController

    before_action :set_claim, only: [:show, :edit, :update, :destroy]


    def nextClaims

        @searchClaims = Claim.nextClaims params[:start], params[:page], 9

        # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
        # remember, its not quite a standard rails approach
        #    searchTemplate = render_to_string partial: 'common/search/prescriber_search_modal_template', locals: { searchPrescribers: @searchPrescribers }, :layout => false

        # when using the technique above, the newlines (\n) have to be removed
        #    render js: "$('#prescriber_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

        render  template: 'common/search/js/nextSearchClaims.js'

    end

    def search_cob
      claim_id = params[:claim_id]
      claim = Claim.find(claim_id)
      pageNumber = params[:page] ? params[:page] : 1
      perPage = 9
      @searchClaimCobs = ClaimCob.select('id,plan_id_code, payor_coverage_type, payor_id, payor_amount_paid, patient_amount')
                 .where('claim_id = :claim_id AND rx_number = :rx_number AND fill_number = :fill_number AND plan_id_code = :plan_id_code',
                  {claim_id: params[:claim_id], rx_number:claim.rx_number, fill_number: claim.fill_number, plan_id_code: claim.plan_id_code})
                 .order(:payor_coverage_type).page(pageNumber).per(perPage)
      render template: 'common/search/js/nextSearchClaimCobs.js'
    end

    def search_dur
      claim_id = params[:claim_id]
      claim = Claim.find(claim_id)
      pageNumber = params[:page] ? params[:page] : 1
      perPage = 9
      @searchClaimDurs = ClaimDur.select('id, dur_code, dur_severity, dur_message')
                 .where('claim_id = :claim_id AND rx_number = :rx_number AND fill_number = :fill_number AND plan_id_code = :plan_id_code',
                  {claim_id: params[:claim_id], rx_number:claim.rx_number, fill_number: claim.fill_number, plan_id_code: claim.plan_id_code})
                  .page(pageNumber).per(perPage)
      render template: 'common/search/js/nextSearchClaimDurs.js'
    end

    def search
      dbContext = Claim.joins(:customer).select('claims.id, rx_number, fill_number, plan_id_code, date_filled, status, total_submitted, cost_submitted, last_name')

      if params[:search_for_rx_number] && params[:search_for_rx_number] != ''
        dbContext = dbContext.where('rx_number = ' + params[:search_for_rx_number])
      end

      if params[:search_for_fill_number] && params[:search_for_fill_number] != ''
        dbContext = dbContext.where('fill_number = ' + params[:search_for_fill_number])
      end

      dbContext = dbContext.where("date_filled >= '" + params[:search_for_from_date] + "'") if params[:search_for_from_date] && params[:search_for_from_date] != ''

      if params[:search_for_status] && params[:search_for_status] != ''
        status = params[:search_for_status]
        if(status == status.to_i.to_s)
          dbContext = dbContext.where('status ='+ status)
        else
          dbContext = dbContext.where('status ='+ Claim.statuses[params[:search_for_status]].to_s)
        end
      end

      if params[:plan_id] && params[:plan_id] != ''
        dbContext = dbContext.where('plan_id ='+ params[:plan_id])
      end

      if params[:customer_id] && params[:customer_id] != ''
        dbContext = dbContext.where('customer_id ='+ params[:customer_id])
      end
      pageNumber = params[:page] ? params[:page] : 1
      perPage = 9
      @searchClaims = dbContext.page(pageNumber).per(perPage)

      render  template: 'common/search/js/nextSearchClaims.js'
    end



  # GET /claims
  # GET /claims.json
  def index
    @claims = Claim.all
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
      @cob_id = params[:cob_selected]
      @dur_id = params[:dur_selected]
      render :edit
  end

  # GET /claims/new
  def new
    @claim = Claim.new
  end

  # GET /claims/1/edit
  def edit
  end

  # POST /claims
  # POST /claims.json
  def create
    @claim = Claim.new(claim_params)

    respond_to do |format|
      if @claim.save
        format.html { redirect_to @claim, notice: 'Claim was successfully created.' }
        format.json { render :show, status: :created, location: @claim }
      else
        format.html { render :new }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claims/1
  # PATCH/PUT /claims/1.json
  def update
    respond_to do |format|
      if @claim.update(claim_params)
        format.html { redirect_to @claim, notice: 'Claim was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim }
      else
        format.html { render :edit }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    @claim.destroy
    respond_to do |format|
      format.html { redirect_to claims_url, notice: 'Claim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:dept_number, :rx_number, :fill_number, :rna_plan_id_number, :transmit_date, :transmit_time, :status, :rna_customer_id_number, :active_flag, :version, :transmission_code, :authorization_number, :exceeds_percent, :dur_on_file, :date_filled, :eligibility_override, :usual_customary_price, :level_of_service, :primary_prescriber_dea_number, :cost_basis, :amount_due, :metric_decimal_quantity, :product_type, :product_code, :incentive_amount, :cost_submitted, :fee_submitted, :tax_submitted,
                                    :communications_error_code, :header_response, :new_plan_number, :cost_paid, :contract_fee, :tax_paid, :total_paid, :accumulated_deductible, :deductible_left, :benefit_left, :amount_to_deductible, :copay_amount, :amount_for_product_selection, :exceeds_benefit_amount, :incentive_fee_paid, :service_fee_paid, :other_amount_fee_paid, :other_payor_amount_recognized, :amount_attributed_to_tax, :partial_copay_amount, :reimbursement_basis, :percent_amount_tax_paid, :tax_rate_paid, :tax_basis,
                                    :help_desk_phone_number, :approved_message_count, :approved_message_code, :network_reimbursement_id, :reject_count, :reject_code, :reject_field_submitted, :transmission_message,
                                    :other_coverage_code, :denial_code, :route_of_administration, :amount_processing_fee, :response_amount_coinsurance, )
    end
end
