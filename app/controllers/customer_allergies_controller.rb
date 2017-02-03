class CustomerAllergiesController < ApplicationController
  before_action :set_customer_allergy, only: [:show, :edit, :update, :destroy]

  # GET /customer_allergies
  # GET /customer_allergies.json
  def index
    @customer_allergies = CustomerAllergy.all
  end

  # GET /customer_allergies/1
  # GET /customer_allergies/1.json
  def show
  end

  # GET /customer_allergies/new
  def new
    @customer_allergy = CustomerAllergy.new
  end

  # GET /customer_allergies/1/edit
  def edit
  end

  # POST /customer_allergies
  # POST /customer_allergies.json
  def create

    customer_allergy_params[:allergy_type] = customer_allergy_params[:allergy_type].to_i

    @customer_allergy = CustomerAllergy.new(customer_allergy_params)

    respond_to do |format|
      if @customer_allergy.save
        format.html { redirect_to @customer_allergy, notice: 'Customer allergy was successfully created.' }
        format.json { render :show, status: :created, location: @customer_allergy }
      else
        format.html { render :new }
        format.json { render json: @customer_allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_allergies/1
  # PATCH/PUT /customer_allergies/1.json
  def update

    customer_allergy_params[:allergy_type] = customer_allergy_params[:allergy_type].to_i

    respond_to do |format|
      if @customer_allergy.update(customer_allergy_params)
        format.html { redirect_to @customer_allergy, notice: 'Customer allergy was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_allergy }
      else
        format.html { render :edit }
        format.json { render json: @customer_allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_allergies/1
  # DELETE /customer_allergies/1.json
  def destroy
    @customer_allergy.destroy
    respond_to do |format|
      format.html { redirect_to customer_allergies_url, notice: 'Customer allergy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_allergy
      @customer_allergy = CustomerAllergy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_allergy_params
      params.require(:customer_allergy).permit(:dept_number, :rna_customer_id_number, :customer_allergy_code, :allergy_type, :allergy_description)
    end
end
