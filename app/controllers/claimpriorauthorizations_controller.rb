class ClaimpriorauthorizationsController < ApplicationController
  before_action :set_claimpriorauthorization, only: [:show, :edit, :update, :destroy]

  # GET /claimpriorauthorizations
  # GET /claimpriorauthorizations.json
  def index
    @claimpriorauthorizations = Claimpriorauthorization.all
  end

  # GET /claimpriorauthorizations/1
  # GET /claimpriorauthorizations/1.json
  def show
  end

  # GET /claimpriorauthorizations/new
  def new
    @claimpriorauthorization = Claimpriorauthorization.new
  end

  # GET /claimpriorauthorizations/1/edit
  def edit
  end

  # POST /claimpriorauthorizations
  # POST /claimpriorauthorizations.json
  def create
    @claimpriorauthorization = Claimpriorauthorization.new(claimpriorauthorization_params)

    respond_to do |format|
      if @claimpriorauthorization.save
        format.html { redirect_to @claimpriorauthorization, notice: 'Claimpriorauthorization was successfully created.' }
        format.json { render :show, status: :created, location: @claimpriorauthorization }
      else
        format.html { render :new }
        format.json { render json: @claimpriorauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claimpriorauthorizations/1
  # PATCH/PUT /claimpriorauthorizations/1.json
  def update
    respond_to do |format|
      if @claimpriorauthorization.update(claimpriorauthorization_params)
        format.html { redirect_to @claimpriorauthorization, notice: 'Claimpriorauthorization was successfully updated.' }
        format.json { render :show, status: :ok, location: @claimpriorauthorization }
      else
        format.html { render :edit }
        format.json { render json: @claimpriorauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claimpriorauthorizations/1
  # DELETE /claimpriorauthorizations/1.json
  def destroy
    @claimpriorauthorization.destroy
    respond_to do |format|
      format.html { redirect_to claimpriorauthorizations_url, notice: 'Claimpriorauthorization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimpriorauthorization
      @claimpriorauthorization = Claimpriorauthorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claimpriorauthorization_params
      params.require(:claimpriorauthorization).permit(:dept_number, :rx_number, :rna_plan_id_number, :authorization_number, :authorization_basis, :begin_date, :end_date, :request_type, :representative_first_name, :representative_last_name, :representative_address, :representative_city, :representative_state, :representative_zip_code, :supporting_text, :response_amount_authorized, :response_effective_date, :response_expiration_date, :refills_authorized, :response_processed_date, :quantity_authorized, :quantity_accumulated)
    end
end
