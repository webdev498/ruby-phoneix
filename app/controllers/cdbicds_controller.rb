class CdbicdsController < ApplicationController
  before_action :set_cdbicd, only: [:show, :edit, :update, :destroy]

  # GET /cdbicds
  # GET /cdbicds.json
  def index
    @cdbicds = Cdbicd.all
  end

  # GET /cdbicds/1
  # GET /cdbicds/1.json
  def show
  end

  # GET /cdbicds/new
  def new
    @cdbicd = Cdbicd.new
  end

  # GET /cdbicds/1/edit
  def edit
  end

  # POST /cdbicds
  # POST /cdbicds.json
  def create
    @cdbicd = Cdbicd.new(cdbicd_params)

    respond_to do |format|
      if @cdbicd.save
        format.html { redirect_to @cdbicd, notice: 'Cdbicd was successfully created.' }
        format.json { render :show, status: :created, location: @cdbicd }
      else
        format.html { render :new }
        format.json { render json: @cdbicd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdbicds/1
  # PATCH/PUT /cdbicds/1.json
  def update
    respond_to do |format|
      if @cdbicd.update(cdbicd_params)
        format.html { redirect_to @cdbicd, notice: 'Cdbicd was successfully updated.' }
        format.json { render :show, status: :ok, location: @cdbicd }
      else
        format.html { render :edit }
        format.json { render json: @cdbicd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdbicds/1
  # DELETE /cdbicds/1.json
  def destroy
    @cdbicd.destroy
    respond_to do |format|
      format.html { redirect_to cdbicds_url, notice: 'Cdbicd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdbicd
      @cdbicd = Cdbicd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdbicd_params
      params.require(:cdbicd).permit(:diagnosis_code, :diagnosis_description, :diagnosis_icd10, :diagnosis_type, :diagnosis_source, :diagnosis_start_date, :diagnosis_end_date)
    end
end
