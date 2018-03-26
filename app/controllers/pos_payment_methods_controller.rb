class PosPaymentMethodsController < ApplicationController
  before_action :set_pos_payment_method, only: [:show, :edit, :update, :destroy]

  # GET /pos_payment_methods
  # GET /pos_payment_methods.json
  def index
    @pos_payment_methods = PosPaymentMethod.all
  end

  # GET /pos_payment_methods/1
  # GET /pos_payment_methods/1.json
  def show
  end

  # GET /pos_payment_methods/new
  def new
    @pos_payment_method = PosPaymentMethod.new
  end

  # GET /pos_payment_methods/1/edit
  def edit
  end

  def posPaymentMethod
    #testing
    @pos_payment_method = PosPaymentMethod.new
  end

  # POST /pos_payment_methods
  # POST /pos_payment_methods.json
  def create
    @pos_payment_method = PosPaymentMethod.new(pos_payment_method_params)

    respond_to do |format|
      if @pos_payment_method.save
        format.html { redirect_to @pos_payment_method, notice: 'Pos payment method was successfully created.' }
        format.json { render :show, status: :created, location: @pos_payment_method }
      else
        format.html { render :new }
        format.json { render json: @pos_payment_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos_payment_methods/1
  # PATCH/PUT /pos_payment_methods/1.json
  def update
    respond_to do |format|
      if @pos_payment_method.update(pos_payment_method_params)
        format.html { redirect_to @pos_payment_method, notice: 'Pos payment method was successfully updated.' }
        format.json { render :show, status: :ok, location: @pos_payment_method }
      else
        format.html { render :edit }
        format.json { render json: @pos_payment_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos_payment_methods/1
  # DELETE /pos_payment_methods/1.json
  def destroy
    @pos_payment_method.destroy
    respond_to do |format|
      format.html { redirect_to pos_payment_methods_url, notice: 'Pos payment method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_payment_method
      @pos_payment_method = PosPaymentMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pos_payment_method_params
      params.require(:pos_payment_method).permit(:company_id, :pharmacy_id, :payment_method_code, :payment_method_description, :payment_method_processing_percent, :merchant_id_number)
    end
end
