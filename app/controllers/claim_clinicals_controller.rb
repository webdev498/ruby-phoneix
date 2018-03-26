class ClaimClinicalsController < ApplicationController
  before_action :set_claim_clinical, only: [:show, :edit, :update, :destroy]

  # GET /claim_clinicals
  # GET /claim_clinicals.json
  def index
    @claim_clinicals = ClaimClinical.all
  end

  # GET /claim_clinicals/1
  # GET /claim_clinicals/1.json
  def show
  end

  # GET /claim_clinicals/new
  def new
    @claim_clinical = ClaimClinical.new
  end

  # GET /claim_clinicals/1/edit
  def edit
  end

  # POST /claim_clinicals
  # POST /claim_clinicals.json
  def create

    claim_clinical_params[:diagnosis_code_qualifier] = claim_clinical_params[:diagnosis_code_qualifier].to_i

    @claim_clinical = ClaimClinical.new(claim_clinical_params)

    respond_to do |format|
      if @claim_clinical.save
        format.html { redirect_to @claim_clinical, notice: 'Claim clinical was successfully created.' }
        format.json { render :show, status: :created, location: @claim_clinical }
      else
        format.html { render :new }
        format.json { render json: @claim_clinical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_clinicals/1
  # PATCH/PUT /claim_clinicals/1.json
  def update

    claim_clinical_params[:diagnosis_code_qualifier] = claim_clinical_params[:diagnosis_code_qualifier].to_i

    respond_to do |format|
      if @claim_clinical.update(claim_clinical_params)
        format.html { redirect_to @claim_clinical, notice: 'Claim clinical was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_clinical }
      else
        format.html { render :edit }
        format.json { render json: @claim_clinical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_clinicals/1
  # DELETE /claim_clinicals/1.json
  def destroy
    @claim_clinical.destroy
    respond_to do |format|
      format.html { redirect_to claim_clinicals_url, notice: 'Claim clinical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_clinical
      @claim_clinical = ClaimClinical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_clinical_params
      params.require(:claim_clinical).permit(:dept_number, :rx_number, :rna_plan_id_code, :diagnosis_counter, :diagnosis_code_qualifier, :diagnosis_code, :clinical_counter, :clinical_date, :clinical_dimension, :clinical_time, :clinical_unit, :clinical_value)
    end
end
