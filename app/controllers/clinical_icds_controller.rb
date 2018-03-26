class ClinicalIcdsController < ApplicationController
  before_action :set_clinical_icd, only: [:show, :edit, :update, :destroy]

  # GET /clinical_icds
  # GET /clinical_icds.json
  def index
    @clinical_icds = ClinicalIcd.all
  end

  # GET /clinical_icds/1
  # GET /clinical_icds/1.json
  def show
  end

  # GET /clinical_icds/new
  def new
    @clinical_icd = ClinicalIcd.new
  end

  # GET /clinical_icds/1/edit
  def edit
  end

  # POST /clinical_icds
  # POST /clinical_icds.json
  def create
    @clinical_icd = ClinicalIcd.new(clinical_icd_params)

    respond_to do |format|
      if @clinical_icd.save
        format.html { redirect_to @clinical_icd, notice: 'Clinical icd was successfully created.' }
        format.json { render :show, status: :created, location: @clinical_icd }
      else
        format.html { render :new }
        format.json { render json: @clinical_icd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinical_icds/1
  # PATCH/PUT /clinical_icds/1.json
  def update
    respond_to do |format|
      if @clinical_icd.update(clinical_icd_params)
        format.html { redirect_to @clinical_icd, notice: 'Clinical icd was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinical_icd }
      else
        format.html { render :edit }
        format.json { render json: @clinical_icd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinical_icds/1
  # DELETE /clinical_icds/1.json
  def destroy
    @clinical_icd.destroy
    respond_to do |format|
      format.html { redirect_to clinical_icds_url, notice: 'Clinical icd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical_icd
      @clinical_icd = ClinicalIcd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_icd_params
      params.require(:clinical_icd).permit(:diagnosis_code, :diagnosis_description, :diagnosis_icd10, :diagnosis_type, :diagnosis_source, :diagnosis_start_date, :diagnosis_end_date)
    end
end
