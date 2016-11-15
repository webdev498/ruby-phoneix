class CdbalgiesController < ApplicationController
  before_action :set_cdbalgy, only: [:show, :edit, :update, :destroy]

  # GET /cdbalgies
  # GET /cdbalgies.json
  def index
    @cdbalgies = Cdbalgy.all
  end

  # GET /cdbalgies/1
  # GET /cdbalgies/1.json
  def show
  end

  # GET /cdbalgies/new
  def new
    @cdbalgy = Cdbalgy.new
  end

  # GET /cdbalgies/1/edit
  def edit
  end

  # POST /cdbalgies
  # POST /cdbalgies.json
  def create
    @cdbalgy = Cdbalgy.new(cdbalgy_params)

    respond_to do |format|
      if @cdbalgy.save
        format.html { redirect_to @cdbalgy, notice: 'Cdbalgy was successfully created.' }
        format.json { render :show, status: :created, location: @cdbalgy }
      else
        format.html { render :new }
        format.json { render json: @cdbalgy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdbalgies/1
  # PATCH/PUT /cdbalgies/1.json
  def update
    respond_to do |format|
      if @cdbalgy.update(cdbalgy_params)
        format.html { redirect_to @cdbalgy, notice: 'Cdbalgy was successfully updated.' }
        format.json { render :show, status: :ok, location: @cdbalgy }
      else
        format.html { render :edit }
        format.json { render json: @cdbalgy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdbalgies/1
  # DELETE /cdbalgies/1.json
  def destroy
    @cdbalgy.destroy
    respond_to do |format|
      format.html { redirect_to cdbalgies_url, notice: 'Cdbalgy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdbalgy
      @cdbalgy = Cdbalgy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdbalgy_params
      params.require(:cdbalgy).permit(:allergy_code, :allergy_description)
    end
end
