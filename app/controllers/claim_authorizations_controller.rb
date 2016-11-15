class ClaimAuthorizationsController < ApplicationController
  before_action :set_claim_authorization, only: [:show, :edit, :update, :destroy]

  # GET /claim_authorizations
  # GET /claim_authorizations.json
  def index
    @claim_authorizations = ClaimAuthorization.all
  end

  # GET /claim_authorizations/1
  # GET /claim_authorizations/1.json
  def show
  end

  # GET /claim_authorizations/new
  def new
    @claim_authorization = ClaimAuthorization.new
  end

  # GET /claim_authorizations/1/edit
  def edit
  end

  # POST /claim_authorizations
  # POST /claim_authorizations.json
  def create
    @claim_authorization = ClaimAuthorization.new(claim_authorization_params)

    respond_to do |format|
      if @claim_authorization.save
        format.html { redirect_to @claim_authorization, notice: 'Claim authorization was successfully created.' }
        format.json { render :show, status: :created, location: @claim_authorization }
      else
        format.html { render :new }
        format.json { render json: @claim_authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_authorizations/1
  # PATCH/PUT /claim_authorizations/1.json
  def update
    respond_to do |format|
      if @claim_authorization.update(claim_authorization_params)
        format.html { redirect_to @claim_authorization, notice: 'Claim authorization was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_authorization }
      else
        format.html { render :edit }
        format.json { render json: @claim_authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_authorizations/1
  # DELETE /claim_authorizations/1.json
  def destroy
    @claim_authorization.destroy
    respond_to do |format|
      format.html { redirect_to claim_authorizations_url, notice: 'Claim authorization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_authorization
      @claim_authorization = ClaimAuthorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_authorization_params
      params.require(:claim_authorization).permit(:dept_number, :rx_number, :fill_number, :rna_plan_id_code, :claim_type, :authorization_number)
    end
end
