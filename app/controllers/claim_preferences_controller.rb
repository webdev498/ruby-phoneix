class ClaimPreferencesController < ApplicationController
  before_action :set_claim_preference, only: [:show, :edit, :update, :destroy]

  # GET /claim_preferences
  # GET /claim_preferences.json
  def index
    @claim_preferences = ClaimPreference.all
  end

  # GET /claim_preferences/1
  # GET /claim_preferences/1.json
  def show
  end

  # GET /claim_preferences/new
  def new
    @claim_preference = ClaimPreference.new
  end

  # GET /claim_preferences/1/edit
  def edit
  end

  # POST /claim_preferences
  # POST /claim_preferences.json
  def create

    claim_preference_params[:product_qualifier] = claim_preference_params[:product_qualifier].to_i

    @claim_preference = ClaimPreference.new(claim_preference_params)

    respond_to do |format|
      if @claim_preference.save
        format.html { redirect_to @claim_preference, notice: 'Claim preference was successfully created.' }
        format.json { render :show, status: :created, location: @claim_preference }
      else
        format.html { render :new }
        format.json { render json: @claim_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_preferences/1
  # PATCH/PUT /claim_preferences/1.json
  def update

    claim_preference_params[:product_qualifier] = claim_preference_params[:product_qualifier].to_i

    respond_to do |format|
      if @claim_preference.update(claim_preference_params)
        format.html { redirect_to @claim_preference, notice: 'Claim preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_preference }
      else
        format.html { render :edit }
        format.json { render json: @claim_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_preferences/1
  # DELETE /claim_preferences/1.json
  def destroy
    @claim_preference.destroy
    respond_to do |format|
      format.html { redirect_to claim_preferences_url, notice: 'Claim preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_preference
      @claim_preference = ClaimPreference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_preference_params
      params.require(:claim_preference).permit(:dept_number, :rna_plan_id_code, :rx_number, :fill_number, :product_count, :product_copay_incentive, :product_incentive, :product_name, :product_id_number, :product_qualifier)
    end
end
