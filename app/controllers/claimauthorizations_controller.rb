class ClaimauthorizationsController < ApplicationController
  before_action :set_claimauthorization, only: [:show, :edit, :update, :destroy]

  # GET /claimauthorizations
  # GET /claimauthorizations.json
  def index
    @claimauthorizations = Claimauthorization.all
  end

  # GET /claimauthorizations/1
  # GET /claimauthorizations/1.json
  def show
  end

  # GET /claimauthorizations/new
  def new
    @claimauthorization = Claimauthorization.new
  end

  # GET /claimauthorizations/1/edit
  def edit
  end

  # POST /claimauthorizations
  # POST /claimauthorizations.json
  def create
    @claimauthorization = Claimauthorization.new(claimauthorization_params)

    respond_to do |format|
      if @claimauthorization.save
        format.html { redirect_to @claimauthorization, notice: 'Claimauthorization was successfully created.' }
        format.json { render :show, status: :created, location: @claimauthorization }
      else
        format.html { render :new }
        format.json { render json: @claimauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claimauthorizations/1
  # PATCH/PUT /claimauthorizations/1.json
  def update
    respond_to do |format|
      if @claimauthorization.update(claimauthorization_params)
        format.html { redirect_to @claimauthorization, notice: 'Claimauthorization was successfully updated.' }
        format.json { render :show, status: :ok, location: @claimauthorization }
      else
        format.html { render :edit }
        format.json { render json: @claimauthorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claimauthorizations/1
  # DELETE /claimauthorizations/1.json
  def destroy
    @claimauthorization.destroy
    respond_to do |format|
      format.html { redirect_to claimauthorizations_url, notice: 'Claimauthorization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimauthorization
      @claimauthorization = Claimauthorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claimauthorization_params
      params.require(:claimauthorization).permit(:dept_number, :rx_number, :fill_number, :rna_plan_id_number, :claim_type, :authorization_number)
    end
end
