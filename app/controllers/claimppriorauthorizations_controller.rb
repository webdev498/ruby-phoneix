class ClaimppriorauthorizationsController < ApplicationController
  before_action :set_claimppriorauthorization, only: [:show, :edit, :update, :destroy]

  # GET /claimppriorauthorizations
  # GET /claimppriorauthorizations.json
  def index
    @claimppriorauthorizations = Claimppriorauthorization.all
  end

  # GET /claimppriorauthorizations/1
  # GET /claimppriorauthorizations/1.json
  def show
  end

  # GET /claimppriorauthorizations/new
  def new
    @claimppriorauthorization = Claimppriorauthorization.new
  end

  # GET /claimppriorauthorizations/1/edit
  def edit
  end

  # POST /claimppriorauthorizations
  # POST /claimppriorauthorizations.json
  def create
    @claimppriorauthorization = Claimppriorauthorization.new(claimppriorauthorization_params)

    respond_to do |format|
      if @claimppriorauthorization.save
        format.html { redirect_to @claimppriorauthorization, notice: 'Claimppriorauthorization was successfully created.' }
        format.json { render :show, status: :created, location: @claimppriorauthorization }
      else
        format.html { render :new }
        format.json { render json: @claimppriorauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claimppriorauthorizations/1
  # PATCH/PUT /claimppriorauthorizations/1.json
  def update
    respond_to do |format|
      if @claimppriorauthorization.update(claimppriorauthorization_params)
        format.html { redirect_to @claimppriorauthorization, notice: 'Claimppriorauthorization was successfully updated.' }
        format.json { render :show, status: :ok, location: @claimppriorauthorization }
      else
        format.html { render :edit }
        format.json { render json: @claimppriorauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claimppriorauthorizations/1
  # DELETE /claimppriorauthorizations/1.json
  def destroy
    @claimppriorauthorization.destroy
    respond_to do |format|
      format.html { redirect_to claimppriorauthorizations_url, notice: 'Claimppriorauthorization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimppriorauthorization
      @claimppriorauthorization = Claimppriorauthorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claimppriorauthorization_params
      params.require(:claimppriorauthorization).permit(:dept_number, :rx_number, :rna_plan_id_number, :authorization_number, :authorization_basis, :begin_date, :end_date, :request_type, :representative_first_name, :representative_last_name, :representative_address, :representative_city, :representative_state, :representative_zip_code, :supporting_text, :response_amount_authorized, :response_effective_date, :response_expiration_date, :refills_authorized, :response_processed_date, :quantity_authorized, :quantity_accumulated)
    end
end
