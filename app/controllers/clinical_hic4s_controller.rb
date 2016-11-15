class ClinicalHic4sController < ApplicationController
  before_action :set_clinical_hic4, only: [:show, :edit, :update, :destroy]

  # GET /clinical_hic4s
  # GET /clinical_hic4s.json
  def index
    @clinical_hic4s = ClinicalHic4.all
  end

  # GET /clinical_hic4s/1
  # GET /clinical_hic4s/1.json
  def show
  end

  # GET /clinical_hic4s/new
  def new
    @clinical_hic4 = ClinicalHic4.new
  end

  # GET /clinical_hic4s/1/edit
  def edit
  end

  # POST /clinical_hic4s
  # POST /clinical_hic4s.json
  def create
    @clinical_hic4 = ClinicalHic4.new(clinical_hic4_params)

    respond_to do |format|
      if @clinical_hic4.save
        format.html { redirect_to @clinical_hic4, notice: 'Clinical hic4 was successfully created.' }
        format.json { render :show, status: :created, location: @clinical_hic4 }
      else
        format.html { render :new }
        format.json { render json: @clinical_hic4.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinical_hic4s/1
  # PATCH/PUT /clinical_hic4s/1.json
  def update
    respond_to do |format|
      if @clinical_hic4.update(clinical_hic4_params)
        format.html { redirect_to @clinical_hic4, notice: 'Clinical hic4 was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinical_hic4 }
      else
        format.html { render :edit }
        format.json { render json: @clinical_hic4.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinical_hic4s/1
  # DELETE /clinical_hic4s/1.json
  def destroy
    @clinical_hic4.destroy
    respond_to do |format|
      format.html { redirect_to clinical_hic4s_url, notice: 'Clinical hic4 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical_hic4
      @clinical_hic4 = ClinicalHic4.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_hic4_params
      params.require(:clinical_hic4).permit(:hic4_sequence_number, :hic4_description, :hic4_root, :hic4_hic, :hic4_salt)
    end
end
