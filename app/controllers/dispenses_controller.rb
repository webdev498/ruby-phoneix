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

    params[:refill_type] = params[:refill_type].to_i
    params[:status] = params[:status].to_i
    params[:cost_basis] = params[:cost_basis].to_i
    params[:other_coverage_code] = params[:other_coverage_code].to_i
    params[:reason_for_delay] = params[:reason_for_delay].to_i
    params[:partial_fill_status] = params[:partial_fill_status].to_i
    params[:reported_to_pmp] = params[:reported_to_pmp].to_i

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

    params[:refill_type] = params[:refill_type].to_i
    params[:status] = params[:status].to_i
    params[:cost_basis] = params[:cost_basis].to_i
    params[:other_coverage_code] = params[:other_coverage_code].to_i
    params[:reason_for_delay] = params[:reason_for_delay].to_i
    params[:partial_fill_status] = params[:partial_fill_status].to_i
    params[:reported_to_pmp] = params[:reported_to_pmp].to_i

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
    def set_dispense_posting_params
  params.require(:dispense).permit(:company_id, :pharmacy_id, :customer_id, :prescription_id, :item_id, :rx_signature_id, :rx_number, :fill_number, :legacy_customer_id_number, :fill_time, :legacy_item_id_number, :refill_type, :status, :split_bill_rx, :billing_complete, :pharmacist_initials, :technician_initials, :quantity, :days_supply, :delivery_route, :lot_number, :serial_number, :discard_date, :price, :usual_customary_price, :base_cost, :acquisition_cost, :fee, :discount, :tax, :ancillary_fee, :professional_service_fee, :cost_basis, :other_coverage_code, :other_amount, :other_amount_type, :reason_for_delay, :denial_override_code, :partial_fill_status, :reported_to_pmp)
    end
end
