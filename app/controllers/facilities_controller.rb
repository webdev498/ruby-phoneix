class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

	def facility
		@facility = Facility.new
	end

  # GET /facilities
  # GET /facilities.json
  def index
    @facilities = Facility.all
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    @facility.wings.build
    cnt = @facility.wings.length
    @facility.wings[cnt-1].name = 'NEW'
    @facility.wings[cnt-1].name = 'NEW'
    @facility.wings[cnt-1].universal_fee = 0
    @facility.wings[cnt-1].unit_dose_fee = 0
    @facility.wings[cnt-1].control_drug_fee = 0
    @facility.wings[cnt-1].narcotic_fee = 0
    render :edit
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
    @facility.wings.build
    @facility.wings[0].name = 'DEFAULT'
    @facility.wings[0].universal_fee = 0
    @facility.wings[0].unit_dose_fee = 0
    @facility.wings[0].control_drug_fee = 0
    @facility.wings[0].narcotic_fee = 0
  end

  # GET /facilities/1/edit
  def edit

  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(facility_params)

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    facility_name = params[:name] ? params[:name] : ''
    pageNumber = params[:page] ? params[:page] : 1
    perPage = 9
    @searchFacilities = Facility.where("name like '#{facility_name}%'").page(pageNumber).per(perPage)
    render template: 'common/search/js/nextSearchFacilities.js'
  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_bed
    bed_id = params[:bed_id]
    Bed.find(bed_id).destroy
    render json: true
  end

  def create_bed
    facility_id = params[:facility_id]
    wing_id = params[:wing_id]
    pass_order = params[:pass_order] ? params[:pass_order] : ''
    bed = params[:bed] ? params[:bed] : ''
    active = params[:active] ? params[:active] : ''

    Bed.create(:pass_order => pass_order, :bed => bed, :active => active, :wing_id => wing_id, :facility_id =>facility_id)
    render json: true
  end

  def update_bed
    bed_id = params[:bed_id]
    pass_order = params[:pass_order] ? params[:pass_order] : ''
    bed = params[:bed] ? params[:bed] : ''
    active = params[:active] ? params[:active] : ''
    Bed.update(bed_id, :pass_order => pass_order, :bed => bed, :active => active)
    render json: true
  end

  def get_beds_by_wing
    wing_id = params[:wing_id]
    data = Wing.find(wing_id).beds.joins("LEFT JOIN customers ON beds.customer_id = customers.id")
               .select('pass_order, bed, beds.active, beds.id,  (customers.first_name || \' \' || customers.middle_name || \' \' || customers.last_name) as customer_name')
               .order(:pass_order).limit(9)
    render json: data
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_params
      params.require(:facility).permit(:active, :id, :phone, :fax, :email, :facility_id_number, :name, :short_name, :active_flag, :address1, :address2, :city, :state, :zip_code, :account_number, :internal_id_number, :state_id_number, :npi_number, :price_schedule, :universal_fee, :unit_dose_fee, :control_drug_fee, :narcotic_fee, :allow_customer_discount, :label_type, :spool_labels, :label_default, :use_expiration_date, :expiration_default, :use_lot_number, :use_doc_u_dose, :default_to_primary_plan, :use_valid_division_codes, :use_form_flags, :use_start_date, :post_zero_copay, :use_auto_fill, :use_patient_counseling, :print_patient_counseling, :select_counseling, :check_dur, :print_monograph, :log_dur_results, :require_hippa_privacy_notice, :print_medication_administration_form, :print_physician_order_form, :print_treatment_form, :print_delivery_receipt, :medication_administration_form, :physician_orders_form, :treatment_form, :print_order, :print_pass_times, :print_other_allergy, :med_administration_routine_heading, :med_administration_prn_heading, :treatment_heading, :print_fill_date, :print_original_date, :print_in_frequency_order, :require_rx_copy_in_facility, :type_of_facility,
      wings_attributes:[:id, :company_id,:pharmacy_id,:facility,:pass_times_id,:active,:name,:contact,:price_schedules,:universal_fee,:unit_dose_fee,:control_drug_fee \
      ,:narcotic_fee,:allow_customer_discount,:label_type,:spool_labels,:label_default,:expiration_date,:expiration_default,:lot_number,:doc_u_dose\
      ,:default_to_primary_plan,:valid_division_codes,:form_flags,:start_date,:post_zero_copay,:frequency_auto_fill,:anniversary_auto_fill,:procycle_auto_fill\
      ,:print_monograph,:log_dur_results,:require_hippa_privacy_notice,:print_medication_guide,:print_medication_administration_form,:print_physician_order_form,:print_treatment_form\
      ,:print_delivery_receipt,:medication_administration_form,:physician_orders_form,:treatment_form,:print_order,:print_pass_times,:print_other_allergy,:med_administration_routine_heading\
      ,:med_administration_prn_heading,:treatment_heading,:print_fill_date,:print_original_date,:print_in_frequency_order,:require_rx_copy_in_facility,:expand_sig_codes,:standing_orders\
      ,:type_of_facility,:emr_interface,:emr_interface_type],
      beds_attributes:[:id,:company_id,:pharmacy_id,:facility_id,:wing_id,:residency_id,:customer_id,:legacy_customer_id_number,:active,:pass_order,:bed,:bed_type,:occupancy_date])
    end
end
