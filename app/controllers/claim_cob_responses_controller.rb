class ClaimCobResponsesController < ApplicationController
  before_action :set_claim_cob_response, only: [:show, :edit, :update, :destroy]

  # GET /claim_cob_responses
  # GET /claim_cob_responses.json
  def index
    @claim_cob_responses = ClaimCobResponse.all
  end

  # GET /claim_cob_responses/1
  # GET /claim_cob_responses/1.json
  def show
  end

  # GET /claim_cob_responses/new
  def new
    @claim_cob_response = ClaimCobResponse.new
  end

  # GET /claim_cob_responses/1/edit
  def edit
  end

  # POST /claim_cob_responses
  # POST /claim_cob_responses.json
  def create

    claim_cob_response_params[:payor_id_qualifier] = claim_cob_response_params[:payor_id_qualifier].to_i
    
    @claim_cob_response = ClaimCobResponse.new(claim_cob_response_params)

    respond_to do |format|
      if @claim_cob_response.save
        format.html { redirect_to @claim_cob_response, notice: 'Claim cob response was successfully created.' }
        format.json { render :show, status: :created, location: @claim_cob_response }
      else
        format.html { render :new }
        format.json { render json: @claim_cob_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_cob_responses/1
  # PATCH/PUT /claim_cob_responses/1.json
  def update

    claim_cob_response_params[:payor_id_qualifier] = claim_cob_response_params[:payor_id_qualifier].to_i

    respond_to do |format|
      if @claim_cob_response.update(claim_cob_response_params)
        format.html { redirect_to @claim_cob_response, notice: 'Claim cob response was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_cob_response }
      else
        format.html { render :edit }
        format.json { render json: @claim_cob_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_cob_responses/1
  # DELETE /claim_cob_responses/1.json
  def destroy
    @claim_cob_response.destroy
    respond_to do |format|
      format.html { redirect_to claim_cob_responses_url, notice: 'Claim cob response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_cob_response
      @claim_cob_response = ClaimCobResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_cob_response_params
      params.require(:claim_cob_response).permit(:dept_number, :rna_plan_id_code, :rx_number, :fill_number, :other_payor_count, :primary_payor_coverage_type, :primary_payor_id_qualifier, :primary_payor_id, :primary_payor_processor_control_number, :primary_payor_card_id_number, :primary_payor_group_number, :primary_payor_person_code, :primary_payor_phone_number, :primary_payor_relation_code, :primary_payor_effective_date, :primary_payor_expiration_date, :primary_payor_benefit_count, :primary_payor_benefit_qualifier, :primary_payor_benefit_amount, :primary_payor_coverage_gap, :secondary_payor_coverage_type, :secondary_payor_id_qualifier, :secondary_payor_id, :secondary_payor_processor_control_number, :secondary_payor_card_id_number, :secondary_payor_group_number, :secondary_payor_person_code, :secondary_payor_phone_number, :secondary_payor_relation_code, :secondary_payor_effective_date, :secondary_payor_expiration_date, :secondary_payor_benefit_count, :secondary_payor_benefit_qualifier, :secondary_payor_benefit_amount, :secondary_payor_coverage_gap, :tertiary_payor_coverage_type, :tertiary_payor_id_qualifier, :tertiary_payor_id, :tertiary_payor_processor_control_number, :tertiary_payor_card_id_number, :tertiary_payor_group_number, :tertiary_payor_person_code, :tertiary_payor_phone_number, :tertiary_payor_relation_code, :tertiary_payor_effective_date, :tertiary_payor_expiration_date, :tertiary_payor_benefit_count, :tertiary_payor_benefit_qualifier, :tertiary_payor_benefit_amount, :tertiary_payor_coverage_gap, :fourth_payor_coverage_type, :fourth_payor_id_qualifier, :fourth_payor_id, :fourth_payor_processor_control_number, :fourth_payor_card_id_number, :fourth_payor_group_number, :fourth_payor_person_code, :fourth_payor_phone_number, :fourth_payor_relation_code, :fourth_payor_effective_date, :fourth_payor_expiration_date, :fourth_payor_benefit_count, :fourth_payor_benefit_qualifier, :fourth_payor_benefit_amount, :fourth_payor_coverage_gap)
    end
end
