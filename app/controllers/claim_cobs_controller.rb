class ClaimCobsController < ApplicationController
  before_action :set_claim_cob, only: [:show, :edit, :update, :destroy]

  # GET /claim_cobs
  # GET /claim_cobs.json
  def index
    @claim_cobs = ClaimCob.all
  end

  # GET /claim_cobs/1
  # GET /claim_cobs/1.json
  def show
  end

  # GET /claim_cobs/new
  def new
    @claim_cob = ClaimCob.new
  end

  # GET /claim_cobs/1/edit
  def edit
  end

  # POST /claim_cobs
  # POST /claim_cobs.json
  def create

    claim_cob_params[:payor_id_qualifier] = claim_cob_params[:payor_id_qualifier].to_i
    claim_cob_params[:patient_amount_qualifier] = claim_cob_params[:patient_amount_qualifier].to_i

    @claim_cob = ClaimCob.new(claim_cob_params)

    respond_to do |format|
      if @claim_cob.save
        format.html { redirect_to @claim_cob, notice: 'Claim cob was successfully created.' }
        format.json { render :show, status: :created, location: @claim_cob }
      else
        format.html { render :new }
        format.json { render json: @claim_cob.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_cobs/1
  # PATCH/PUT /claim_cobs/1.json
  def update

    claim_cob_params[:payor_id_qualifier] = claim_cob_params[:payor_id_qualifier].to_i
    claim_cob_params[:patient_amount_qualifier] = claim_cob_params[:patient_amount_qualifier].to_i

    respond_to do |format|
      if @claim_cob.update(claim_cob_params)
        format.html { redirect_to @claim_cob, notice: 'Claim cob was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_cob }
      else
        format.html { render :edit }
        format.json { render json: @claim_cob.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_cobs/1
  # DELETE /claim_cobs/1.json
  def destroy
    @claim_cob.destroy
    respond_to do |format|
      format.html { redirect_to claim_cobs_url, notice: 'Claim cob was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_cob
      @claim_cob = ClaimCob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_cob_params
      params.require(:claim_cob).permit(:dept_number, :rna_plan_id_code, :rx_number, :fill_number, :other_payor_count, :primary_payor_coverage_type, :primary_payor_id_qualifier, :primary_payor_id, :primary_payor_date, :primary_payor_reject_count, :primary_payor_reject_code, :primary_payor_paid_count, :primary_payor_paid_qualifier, :primary_payor_amount_paid, :primary_patient_amount_qualifier, :primary_patient_amount, :primary_benefit_qualifier, :primary_benefit_amount, :primary_control_number, :secondary_payor_coverage_type, :secondary_payor_id_qualifier, :secondary_payor_id, :secondary_payor_date, :secondary_payor_reject_count, :secondary_payor_reject_code, :secondary_payor_paid_count, :secondary_payor_paid_qualifier, :secondary_payor_amount_paid, :secondary_patient_amount_qualifier, :secondary_patient_amount, :secondary_benefit_qualifier, :secondary_benefit_amount, :secondary_control_number, :tertiary_payor_coverage_type, :tertiary_payor_id_qualifier, :tertiary_payor_id, :tertiary_payor_date, :tertiary_payor_reject_count, :tertiary_payor_reject_code, :tertiary_payor_paid_count, :tertiary_payor_paid_qualifier, :tertiary_payor_amount_paid, :tertiary_patient_amount_qualifier, :tertiary_patient_amount, :tertiary_benefit_qualifier, :tertiary_benefit_amount, :tertiary_control_number, :fourth_payor_coverage_type, :fourth_payor_id_qualifier, :fourth_payor_id, :fourth_payor_date, :fourth_payor_reject_count, :fourth_payor_reject_code, :fourth_payor_paid_count, :fourth_payor_paid_qualifier, :fourth_payor_amount_paid, :fourth_patient_amount_qualifier, :fourth_patient_amount, :fourth_benefit_qualifier, :fourth_benefit_amount, :fourth_control_number)
    end
end
