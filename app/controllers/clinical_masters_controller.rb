class ClinicalMastersController < ApplicationController
  before_action :set_clinical_master, only: [:show, :edit, :update, :destroy]

  # GET /clinical_masters
  # GET /clinical_masters.json
  def index
    @clinical_masters = ClinicalMaster.all
  end

  # GET /clinical_masters/1
  # GET /clinical_masters/1.json
  def show
  end

  # GET /clinical_masters/new
  def new
    @clinical_master = ClinicalMaster.new
  end

  # GET /clinical_masters/1/edit
  def edit
  end

  # POST /clinical_masters
  # POST /clinical_masters.json
  def create
    @clinical_master = ClinicalMaster.new(clinical_master_params)

    respond_to do |format|
      if @clinical_master.save
        format.html { redirect_to @clinical_master, notice: 'Clinical master was successfully created.' }
        format.json { render :show, status: :created, location: @clinical_master }
      else
        format.html { render :new }
        format.json { render json: @clinical_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinical_masters/1
  # PATCH/PUT /clinical_masters/1.json
  def update
    respond_to do |format|
      if @clinical_master.update(clinical_master_params)
        format.html { redirect_to @clinical_master, notice: 'Clinical master was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinical_master }
      else
        format.html { render :edit }
        format.json { render json: @clinical_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinical_masters/1
  # DELETE /clinical_masters/1.json
  def destroy
    @clinical_master.destroy
    respond_to do |format|
      format.html { redirect_to clinical_masters_url, notice: 'Clinical master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinical_master
      @clinical_master = ClinicalMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinical_master_params
      params.require(:clinical_master).permit(:ndc_number, :gcn_seqno, :label_name, :labeler_id, :package_size, :additional_description, :previous_ndc_number, :new_ndc_number, :ndc_format_flag, :clinical_drug_class, :date_added, :date_updated, :generic_product_indicator, :drug_form, :stocked_in_hospital_flag, :innovator_flag, :stocked_in_nursing_home_flag, :stocked_in_retail_flag, :maintenance_drug, :home_health_flag, :manufacturer, :patient_package_insert, :standard_package_size, :repackaged, :top_200_ranking, :unit_dose, :case_pack, :color, :flavor, :shape, :unit_of_use, :label_name25, :awp_update_date, :private_labeler, :hcpc_code, :top_50_generic, :generic_named_drug, :generic_therapeutic_indicator, :generic_id1, :drug_unit_cost, :drug_package_cost, :drug_unit_mac, :drug_unit_awp, :drug_package_awp, :orange_book_code, :orange_book_code_expanded, :orange_book_code3, :package_size_equivalent, :brand_name, :dea_schedule, :gcn_number, :monograph, :hispanic_monograph, :strength, :drug_category_class, :generic_therapeutic_class, :therapeutic_class, :route, :dose_form, :hicl_sequence_number, :gender, :hierarchial_ingredient_code3, :hierarchial_ingredient_sequence_number, :strength_number, :strength_units, :volume_number, :volume_units, :min_max_adult_minimum_daily_dose_strength_quantity, :min_max_adult_minimum_daily_dose_strength_units, :min_max_adult_minimum_daily_dose_units_quantity, :min_max_adult_minimum_daily_dose_units_form, :min_max_adult_maximum_daily_dose_strength_quantity, :min_max_adult_maximum_daily_dose_strength_units, :min_max_adult_maximum_daily_dose_units_quantity, :min_max_adult_maximum_daily_dose_units_form, :min_max_geriatric_minimum_daily_dose_strength_quantity, :min_max_geriatric_minimum_daily_dose_strength_units, :min_max_geriatric_minimum_daily_dose_units_quantity, :min_max_geriatric_minimum_daily_dose_units_form, :min_max_geriatric_maximum_daily_dose_strength_quantity, :min_max_geriatric_maximum_daily_dose_strength_units, :min_max_geriatric_maximum_daily_dose_units_quantity, :min_max_geriatric_maximum_daily_dose_units_form, :ahfs_code, :drug_disease_contraindication_codes, :counseling_message_codes, :interaction_codes, :geriatric_codes, :pediatric_codes, :indication_codes, :lactation_codes, :pregnancy_codes, :side_effect_codes, :label_codes, :drug_food_interaction_codes, :drug_lab_interference_codes, :duplicate_therapy_codes, :hierarchial_ingredient_sequence_number_list, :hierarchial_ingredient_code_root)
    end
end
