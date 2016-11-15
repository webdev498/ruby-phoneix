class ClinicalsController < ApplicationController
  before_action :set_clinical, only: [:show, :edit, :update, :destroy]

  # GET /clinicals
  # GET /clinicals.json
  def index
    @clinicals = Clinical.all
  end

  # GET /clinicals/1
  # GET /clinicals/1.json
  def show
  end

  # GET /clinicals/new
  def new
    @clinical = Clinical.new
  end

  # GET /clinicals/1/edit
  def edit
  end

  # POST /clinicals
  # POST /clinicals.json
  def create
    @clinical = Clinical.new(clinical_params)

    respond_to do |format|
      if @clinical.save
        format.html { redirect_to @clinical, notice: 'Clinical was successfully created.' }
        format.json { render :show, status: :created, location: @clinical }
      else
        format.html { render :new }
        format.json { render json: @clinical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinicals/1
  # PATCH/PUT /clinicals/1.json
  def update
    respond_to do |format|
      if @clinical.update(clinical_params)
        format.html { redirect_to @clinical, notice: 'Clinical was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinical }
      else
        format.html { render :edit }
        format.json { render json: @clinical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinicals/1
  # DELETE /clinicals/1.json
  def destroy
    @clinical.destroy
    respond_to do |format|
      format.html { redirect_to clinicals_url, notice: 'Clinical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical
      @clinical = Clinical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_params
      params.require(:clinical).permit(:new_allergy, :existing_allergies, :new_diagnosis, :existing_diagnosis, :new_other_allergy, :existing_other_allergies)
    end
end
