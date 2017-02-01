class ElectronicPrescriptionsController < ApplicationController

  before_action :set_electronic_prescription, only: [:show, :edit, :update, :destroy]


  def nextElectronicPrescriptionsByCustomer
    @searchElectronicPrescriptions = ElectronicPrescription.nextElectronicPrescriptionsByCustomer params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchElectronicPrescriptions.js'

  end

  def nextElectronicPrescriptionsByPrescriber
    @searchElectronicPrescriptions = ElectronicPrescription.nextElectronicPrescriptionsByPrescriber params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchElectronicPrescriptions.js'

  end

  def nextElectronicPrescriptionsByItem
    @searchElectronicPrescriptions = ElectronicPrescription.nextElectronicPrescriptionsByItem params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchElectronicPrescriptions.js'

  end



  # GET /electronic_prescriptions/1
  # GET /electronic_prescriptions/1.json
  def show
    PhxErxProcessor.parse_erx_file @electronic_prescription
    render :edit
  end

  # GET /electronic_prescriptions/new
  def new
    @electronic_prescription = ElectronicPrescription.new
  end

  # GET /electronic_prescriptions/1/edit
  def edit
    PhxErxProcessor.parse_erx_file @electronic_prescription
  end


  # POST /electronic_prescriptions
  # POST /electronic_prescriptions.json
  def create

    electronic_prescription_params[:status] = electronic_prescription_params[:status].to_i
    @electronic_prescription = ElectronicPrescription.new(electronic_prescription_params)

    respond_to do |format|
      if @electronic_prescription.save
        format.html { redirect_to @electronic_prescription, notice: 'Electronic prescription was successfully created.' }
        format.json { render :show, status: :created, location: @electronic_prescription }
      else
        format.html { render :new }
        format.json { render json: @electronic_prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /electronic_prescriptions/1
  # PATCH/PUT /electronic_prescriptions/1.json
  def update

    electronic_prescription_params[:status] = electronic_prescription_params[:status].to_i

    respond_to do |format|
      if @electronic_prescription.update(electronic_prescription_params)
        format.html { redirect_to @electronic_prescription, notice: 'Electronic prescription was successfully updated.' }
        format.json { render :show, status: :ok, location: @electronic_prescription }
      else
        format.html { render :edit }
        format.json { render json: @electronic_prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /electronic_prescriptions/1
  # DELETE /electronic_prescriptions/1.json
  def destroy
    @electronic_prescription.destroy
    respond_to do |format|
      format.html { redirect_to electronic_prescriptions_url, notice: 'Electronic prescription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_electronic_prescription
      @electronic_prescription = ElectronicPrescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def electronic_prescription_params
      params.require(:electronic_prescription).permit(:transmission_number, :prescriber_spi_number, :prescriber_order_number, :prescriber_reference_number, :prescriber_reference_number_qualifier, :prescriber_clinic_name_extended, :prescriber_service_location, :prescriber_facility_qualifier, :prescriber_facility_code, :prescriber_claim_frequency, :prescriber_specialty, :prescriber_agency_qualifier, :prescriber_specialty_code, :prescriber_last_name, :prescriber_first_name, :prescriber_middle_name, :prescriber_suffix, :prescriber_prefix, :prescriber_zip_code, :prescriber_clinic_name, :prescriber_clinic_address1, :prescriber_clinic_address2, :prescriber_clinic_city, :prescriber_clinic_state, :prescriber_clinic_zip, :prescriber_phone_number, :prescriber_phone_number_qualifier, :prescriber_agent_last_name, :prescriber_agent_first_name, :prescriber_agent_middle_name, :prescriber_agent_suffix, :prescriber_agent_prefix, :patient_individual_relationship, :patient_birthdate, :patient_last_name, :patient_first_name, :patient_middle_name, :patient_suffix, :patient_prefix, :patient_gender, :patient_id_number, :patient_id_number_qualifier, :patient_address1, :patient_address2, :patientcity, :patient_state, :patient_zip, :patient_phone_number, :patient_phone_number_qualifier, :item_description, :item_number, :item_number_qualiifer, :item_dosage_form_code, :item_strength, :item_strength_quallifier, :item_database_code, :item_database_source, :item_name_long1, :item_name_long2, :item_name_long3, :item_form_source_code, :item_form_code, :item_strength_source_code, :item_drug_strength, :item_dea_schedule, :item_quantity_qualifier, :item_quantity, :item_quantity_list_qualiifer, :item_quantity_unit_source_code, :item_quantity_potency_code, :item_sig1, :item_sig2, :item_date_qualifier, :item_date, :item_date_format, :item_substitution_code, :item_refill_prescribed_qualifier, :item_refill_prescribed, :diagnosis_qualifier, :diagnosis_code, :prior_authorization_number, :prior_authorization_qualifier, :free_text, :dur_reason_code, :dur_professional_code, :dur_result_code, :coagent_id, :coagent_id_qualifier, :clinical_priority, :acknowledgement_reason, :coverage_status_code, :prior_authorization_status, :do_not_fill, :need_by_date_qualifier, :need_by_date, :need_by_date_format, :timezone_id, :timezon_different_quantity, :need_by_reason, :supervisor_spi_number, :supervisor_qualifier, :supervisor_facility_qualifier, :supervisor_facility_code, :supervisor_claim_frequency, :supervisor_specialty, :supervisor_agency_qualifier, :supervisor_specialty_code, :supervisor_last_name, :supervisor_first_name, :supervisor_middle_name, :supervisor_suffix, :supervisor_prefix, :supervisor_zip_code, :supervisor_clinic_name, :supervisor_clinic_address1, :supervisor_clinic_address2, :supervisor_clinic_city, :supervisor_clinic_state, :supervisor_clinic_zip, :supervisor_phone_number, :supervisor_phone_number_qualifier, :supervisor_agent_last_name, :supervisor_agent_first_name, :supervisor_agent_middle_name, :supervisor_agent_suffix, :supervisor_agent_prefix)
    end
end
