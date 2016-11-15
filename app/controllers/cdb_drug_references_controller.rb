class CdbDrugReferencesController < ApplicationController
  before_action :set_cdb_drug_reference, only: [:show, :edit, :update, :destroy]

  # GET /cdb_drug_references
  # GET /cdb_drug_references.json
  def index
    @cdb_drug_references = CdbDrugReference.all
  end

  # GET /cdb_drug_references/1
  # GET /cdb_drug_references/1.json
  def show
  end

  # GET /cdb_drug_references/new
  def new
    @cdb_drug_reference = CdbDrugReference.new
  end

  # GET /cdb_drug_references/1/edit
  def edit
  end

  # POST /cdb_drug_references
  # POST /cdb_drug_references.json
  def create
    @cdb_drug_reference = CdbDrugReference.new(cdb_drug_reference_params)

    respond_to do |format|
      if @cdb_drug_reference.save
        format.html { redirect_to @cdb_drug_reference, notice: 'Cdb drug reference was successfully created.' }
        format.json { render :show, status: :created, location: @cdb_drug_reference }
      else
        format.html { render :new }
        format.json { render json: @cdb_drug_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdb_drug_references/1
  # PATCH/PUT /cdb_drug_references/1.json
  def update
    respond_to do |format|
      if @cdb_drug_reference.update(cdb_drug_reference_params)
        format.html { redirect_to @cdb_drug_reference, notice: 'Cdb drug reference was successfully updated.' }
        format.json { render :show, status: :ok, location: @cdb_drug_reference }
      else
        format.html { render :edit }
        format.json { render json: @cdb_drug_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdb_drug_references/1
  # DELETE /cdb_drug_references/1.json
  def destroy
    @cdb_drug_reference.destroy
    respond_to do |format|
      format.html { redirect_to cdb_drug_references_url, notice: 'Cdb drug reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdb_drug_reference
      @cdb_drug_reference = CdbDrugReference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdb_drug_reference_params
      params.require(:cdb_drug_reference).permit(:ndc_number, :ndc_number10, :ddid_number, :kdc_code, :drug_name, :generic_product_id, :therapeutic_equivalence_eval_code, :dea_schedule, :desi_code, :rx_otc_indicator, :generic_packaging_code, :previous_ndc_number, :new_ndc_number, :repackage_code, :id_number_format, :package_size, :package_size_unit_measure, :package_size_quantity, :mfg_name, :third_party_restriction_code, :kdc_flag, :labeler_id_number, :multi_source_code, :name_type_code, :item_status_flag, :innerpack_code, :clinic_pack_code, :pharmacy_stocked_indicator, :hospital_stocked_indicator, :dispensing_unit_code, :dollar_rank_code, :rx_rank_code, :storage_code, :limited_distribution_code, :old_ndc_effective_date, :new_ndc_effective_date, :next_smaller_ndc, :next_larger_ndc, :last_change_date, :awp_unit_price, :awp_package_price, :awp_last_change_date, :direct_unit_price, :direct_package_price, :direct_last_change_date, :wac_unit_price, :wac_package_price, :wac_last_change_date, :federal_mac_unit_price, :federal_mac_last_change_date, :federal_mac_unit_dose, :federal_mac_unitdose_last_change_date, :route_of_admin_code, :dosage_form, :drug_strength, :strength_unit_measure, :bioequivalence_code, :controlled_substance_code, :efficacy_code, :legend_indicator, :brand_name_code, :name_source_code, :new_ddid_number, :screenable_flag, :local_systemic_flag, :maintenance_code, :form_type_code, :internal_external_code, :single_combo_code, :representative_gpi_flag, :representative_kdc_flag, :clarity, :coating, :color, :flavor, :scored, :shape, :image_file_name, :side1_imprint, :side2_imprint, :appearance_text, :medication_guide_file, :monitoring_program, :monitoring_file_name, :monograph_file_name, :black_box_file_name, :contains_acetaminophen, :contains_pseudoephedrine)
    end
end
