class DispensesController < ApplicationController
  before_action :set_dispense, only: [:show, :edit, :update, :destroy]

  # GET /dispenses
  # GET /dispenses.json
  def index
    @dispenses = Dispense.all
  end

  # GET /dispenses/1
  # GET /dispenses/1.json
  def show
  end

  # GET /dispenses/new
  def new
    @dispense = Dispense.new
  end

  # GET /dispenses/1/edit
  def edit
  end

  # POST /dispenses
  # POST /dispenses.json
  def create
    @dispense = Dispense.new(dispense_params)

    respond_to do |format|
      if @dispense.save
        format.html { redirect_to @dispense, notice: 'Dispense was successfully created.' }
        format.json { render :show, status: :created, location: @dispense }
      else
        format.html { render :new }
        format.json { render json: @dispense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dispenses/1
  # PATCH/PUT /dispenses/1.json
  def update
    respond_to do |format|
      if @dispense.update(dispense_params)
        format.html { redirect_to @dispense, notice: 'Dispense was successfully updated.' }
        format.json { render :show, status: :ok, location: @dispense }
      else
        format.html { render :edit }
        format.json { render json: @dispense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dispenses/1
  # DELETE /dispenses/1.json
  def destroy
    @dispense.destroy
    respond_to do |format|
      format.html { redirect_to dispenses_url, notice: 'Dispense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dispense
      @dispense = Dispense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dispense_params
      params.require(:dispense).permit(:dept_number, :rx_number, :fill_number, :rna_customer_id_number, :fill_date, :rna_item_id_number, :active_flag, :refill_type, :refill_status, :split_bill_rx, :billing_complete, :pharmacist_initials, :technician_initials, :fill_time, :fill_quantity, :fill_days_supply, :route_of_delivery, :lot_number, :discard_date, :fill_price, :base_cost, :actual_cost, :fill_fee, :copay, :discount, :tax, :ancillary_fee, :professional_service_fee, :cost_basis, :other_coverage_code, :other_amount, :other_amount_type, :prior_auth_type, :reason_for_delay, :denial_override_code, :dispense_status, :charge_amount, :posted_flag, :primary_paytype, :primary_paytype_amount, :primary_paytype_billed, :secondary_paytype, :secondary_paytype_amount, :secondary_paytype_billed, :tertiary_paytype, :tertiary_paytype_amount, :tertiary_paytype_billed, :fourth_paytype, :fourth_paytype_amount, :fourth_paytype_billed, :fifth_paytype, :fifth_paytype_amount, :fifth_paytype_billed)
    end
end
