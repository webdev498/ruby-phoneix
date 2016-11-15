class RxoptionsController < ApplicationController
  before_action :set_rxoption, only: [:show, :edit, :update, :destroy]



  def parameterMaintenance
    #testing
    @rxoption = Rxoption.find(1)
  end



  # GET /rxoptions
  # GET /rxoptions.json
  def index
    @rxoptions = Rxoption.all
  end

  # GET /rxoptions/1
  # GET /rxoptions/1.json
  def show
  end

  # GET /rxoptions/new
  def new
    @rxoption = Rxoption.new
  end

  # GET /rxoptions/1/edit
  def edit
  end

  # POST /rxoptions
  # POST /rxoptions.json
  def create
    @rxoption = Rxoption.new(rxoption_params)

    respond_to do |format|
      if @rxoption.save
        format.html { redirect_to @rxoption, notice: 'Rxoption was successfully created.' }
        format.json { render :show, status: :created, location: @rxoption }
      else
        format.html { render :new }
        format.json { render json: @rxoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rxoptions/1
  # PATCH/PUT /rxoptions/1.json
  def update
    respond_to do |format|
      if @rxoption.update(rxoption_params)
        format.html { redirect_to @rxoption, notice: 'Rxoption was successfully updated.' }
        format.json { render :show, status: :ok, location: @rxoption }
      else
        format.html { render :edit }
        format.json { render json: @rxoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rxoptions/1
  # DELETE /rxoptions/1.json
  def destroy
    @rxoption.destroy
    respond_to do |format|
      format.html { redirect_to rxoptions_url, notice: 'Rxoption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rxoption
      @rxoption = Rxoption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rxoption_params
      params.require(:rxoption).permit(:dept_number, :days_until_expiration, :cost_report_option, :last_new_rx_number, :use_split_billing, :process_internet_claims, :data_collection, :switch_type, :erx_interface, :print_erx_hard_copy, :use_erx_refill_authorization, :submit_cash_rx, :submit_cash_paytype, :use_refill_thru, :use_daily_quantity, :use_expiration_date, :use_lot_number, :use_discard_date, :use_delivery_route, :use_route_of_administration, :use_manual_counseling, :use_dea_documentation, :use_realtime_drug_reporting, :use_privacy_warning, :use_workflow, :display_rx_profile, :display_customer_note, :display_prescriber_note, :display_item_note, :display_rx_note, :default_paytype_option, :allow_rx_charge_account, :label_type, :print_discount_on_label, :print_barcode_on_label, :print_barcode_on_receipt, :print_store_heading, :print_pharmex_labels, :require_date_written_entry, :use_fax_interface, :use_text_message, :use_email_messages, :use_rna_web_portal, :use_doc_u_dose, :use_nursing_home, :ivr_interface, :robotic_interface, :remote_prescriber_interface, :remote_customer_interface, :customer_wellness, :netrx_interface, :prescribe_wellness_interface, :cover_my_meds_interface, :script_ability_interface, :system_type, :system_network_type)
    end
end
