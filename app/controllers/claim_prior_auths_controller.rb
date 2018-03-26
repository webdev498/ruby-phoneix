class ClaimPriorAuthsController < ApplicationController
  before_action :set_claim_prior_auth, only: [:show, :edit, :update, :destroy]

  # GET /claim_prior_auths
  # GET /claim_prior_auths.json
  def index
    @claim_prior_auths = ClaimPriorAuth.all
  end

  # GET /claim_prior_auths/1
  # GET /claim_prior_auths/1.json
  def show
  end

  # GET /claim_prior_auths/new
  def new
    @claim_prior_auth = ClaimPriorAuth.new
  end

  # GET /claim_prior_auths/1/edit
  def edit
  end

  # POST /claim_prior_auths
  # POST /claim_prior_auths.json
  def create

    claim_prior_auth_params[:authorization_basis] = claim_prior_auth_params[:authorization_basis].to_i
    claim_prior_auth_params[:request_type] = claim_prior_auth_params[:request_type].to_i

    @claim_prior_auth = ClaimPriorAuth.new(claim_prior_auth_params)

    respond_to do |format|
      if @claim_prior_auth.save
        format.html { redirect_to @claim_prior_auth, notice: 'Claim prior auth was successfully created.' }
        format.json { render :show, status: :created, location: @claim_prior_auth }
      else
        format.html { render :new }
        format.json { render json: @claim_prior_auth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_prior_auths/1
  # PATCH/PUT /claim_prior_auths/1.json
  def update

    claim_prior_auth_params[:authorization_basis] = claim_prior_auth_params[:authorization_basis].to_i
    claim_prior_auth_params[:request_type] = claim_prior_auth_params[:request_type].to_i

    respond_to do |format|
      if @claim_prior_auth.update(claim_prior_auth_params)
        format.html { redirect_to @claim_prior_auth, notice: 'Claim prior auth was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_prior_auth }
      else
        format.html { render :edit }
        format.json { render json: @claim_prior_auth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_prior_auths/1
  # DELETE /claim_prior_auths/1.json
  def destroy
    @claim_prior_auth.destroy
    respond_to do |format|
      format.html { redirect_to claim_prior_auths_url, notice: 'Claim prior auth was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_prior_auth
      @claim_prior_auth = ClaimPriorAuth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_prior_auth_params
      params.require(:claim_prior_auth).permit(:dept_number, :rx_number, :rna_plan_id_code, :authorization_number, :authorization_basis, :effective_date, :expiration_date, :request_type, :representative_first_name, :representative_last_name, :representative_address, :representative_city, :representative_state, :representative_zip_code, :supporting_text, :response_amount_authorized, :response_effective_date, :response_expiration_date, :refills_authorized, :response_processed_date, :quantity_authorized, :quantity_accumulated)
    end
end
