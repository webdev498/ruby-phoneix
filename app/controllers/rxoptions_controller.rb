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

    rxoption_params[:cost_report_option] = rxoption_params[:cost_report_option].to_i
    rxoption_params[:switch_type] = rxoption_params[:switch_type].to_i
    rxoption_params[:erx_interface] = rxoption_params[:erx_interface].to_i
    rxoption_params[:default_paytype_option] = rxoption_params[:default_paytype_option].to_i
    rxoption_params[:system_type] = rxoption_params[:system_type].to_i
    rxoption_params[:system_network_type] = rxoption_params[:system_network_type].to_i

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

    rxoption_params[:cost_report_option] = rxoption_params[:cost_report_option].to_i
    rxoption_params[:switch_type] = rxoption_params[:switch_type].to_i
    rxoption_params[:erx_interface] = rxoption_params[:erx_interface].to_i
    rxoption_params[:default_paytype_option] = rxoption_params[:default_paytype_option].to_i
    rxoption_params[:system_type] = rxoption_params[:system_type].to_i
    rxoption_params[:system_network_type] = rxoption_params[:system_network_type].to_i

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
      params.require(:rxoption).permit(:company_id, :pharmacy_id, :days_until_expiration, :cost_report_option, :last_new_rx_number, :use_split_billing, :process_internet_claims, :data_collection, :switch_type, :erx_interface, :print_erx_hard_copy, :erx_refill_request, :submit_cash_rx, :submit_cash_paytype, :refill_through_number_days, :enter_daily_quantity, :enter_expiration_date, :enter_lot_number, :enter_serialization_info, :enter_discard_date, :enter_delivery_route, :enter_route_of_administration, :manual_counseling, :additional_dea_documentation, :realtime_drug_reporting, :privacy_warning, :workflow, :display_rx_profile, :display_customer_note, :display_prescriber_note, :display_item_note, :display_rx_note, :default_paytype_option, :allow_rx_charge_account, :label_type, :print_discount_on_label, :print_barcode_on_label, :print_barcode_on_receipt, :print_store_heading, :print_warning_labels, :require_date_written_entry, :fax_interface, :text_message, :email_messages, :web_portal, :doc_u_dose, :nursing_home, :ivr_interface, :robotic_interface, :remote_prescriber_interface, :remote_customer_interface, :customer_wellness, :netrx_interface, :prescribe_wellness_interface, :cover_my_meds_interface, :script_ability_interface, :system_type, :system_network_type, :med_tablet, :drug_pedigree, :imedicare)
    end
end
