class ClinicalAllergiesController < ApplicationController
  before_action :set_clinical_allergy, only: [:show, :edit, :update, :destroy]

  # GET /clinical_allergies
  # GET /clinical_allergies.json
  def index
    @clinical_allergies = ClinicalAllergy.all
  end

  # GET /clinical_allergies/1
  # GET /clinical_allergies/1.json
  def show
  end

  # GET /clinical_allergies/new
  def new
    @clinical_allergy = ClinicalAllergy.new
  end

  # GET /clinical_allergies/1/edit
  def edit
  end

  # POST /clinical_allergies
  # POST /clinical_allergies.json
  def create
    @clinical_allergy = ClinicalAllergy.new(clinical_allergy_params)

    respond_to do |format|
      if @clinical_allergy.save
        format.html { redirect_to @clinical_allergy, notice: 'Clinical allergy was successfully created.' }
        format.json { render :show, status: :created, location: @clinical_allergy }
      else
        format.html { render :new }
        format.json { render json: @clinical_allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinical_allergies/1
  # PATCH/PUT /clinical_allergies/1.json
  def update
    respond_to do |format|
      if @clinical_allergy.update(clinical_allergy_params)
        format.html { redirect_to @clinical_allergy, notice: 'Clinical allergy was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinical_allergy }
      else
        format.html { render :edit }
        format.json { render json: @clinical_allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinical_allergies/1
  # DELETE /clinical_allergies/1.json
  def destroy
    @clinical_allergy.destroy
    respond_to do |format|
      format.html { redirect_to clinical_allergies_url, notice: 'Clinical allergy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical_allergy
      @clinical_allergy = ClinicalAllergy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_allergy_params
      params.require(:clinical_allergy).permit(:allergy_code, :allergy_description)
    end
end
