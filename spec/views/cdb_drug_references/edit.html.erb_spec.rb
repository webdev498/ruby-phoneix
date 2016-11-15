require 'rails_helper'

RSpec.describe "cdb_drug_references/edit", type: :view do
  before(:each) do
    @cdb_drug_reference = assign(:cdb_drug_reference, CdbDrugReference.create!(
      :ndc_number => 1,
      :ndc_number10 => 1,
      :ddid_number => 1,
      :kdc_code => 1,
      :drug_name => "MyString",
      :generic_product_id => "MyString",
      :therapeutic_equivalence_eval_code => "MyString",
      :dea_schedule => "MyString",
      :desi_code => "MyString",
      :rx_otc_indicator => "MyString",
      :generic_packaging_code => "MyString",
      :previous_ndc_number => 1,
      :new_ndc_number => 1,
      :repackage_code => "MyString",
      :id_number_format => "MyString",
      :package_size => "9.99",
      :package_size_unit_measure => "MyString",
      :package_size_quantity => 1,
      :mfg_name => "MyString",
      :third_party_restriction_code => "MyString",
      :kdc_flag => "MyString",
      :labeler_id_number => 1,
      :multi_source_code => "MyString",
      :name_type_code => "MyString",
      :item_status_flag => "MyString",
      :innerpack_code => "MyString",
      :clinic_pack_code => "MyString",
      :pharmacy_stocked_indicator => "MyString",
      :hospital_stocked_indicator => "MyString",
      :dispensing_unit_code => "MyString",
      :dollar_rank_code => "MyString",
      :rx_rank_code => "MyString",
      :storage_code => "MyString",
      :limited_distribution_code => "MyString",
      :next_smaller_ndc => "MyString",
      :next_larger_ndc => "MyString",
      :awp_unit_price => "9.99",
      :awp_package_price => "9.99",
      :direct_unit_price => "9.99",
      :direct_package_price => "9.99",
      :wac_unit_price => "9.99",
      :wac_package_price => "9.99",
      :federal_mac_unit_price => "9.99",
      :federal_mac_unit_dose => "9.99",
      :route_of_admin_code => "MyString",
      :dosage_form => "MyString",
      :drug_strength => "MyString",
      :strength_unit_measure => "MyString",
      :bioequivalence_code => "MyString",
      :controlled_substance_code => "MyString",
      :efficacy_code => "MyString",
      :legend_indicator => "MyString",
      :brand_name_code => "MyString",
      :name_source_code => "MyString",
      :new_ddid_number => 1,
      :screenable_flag => "MyString",
      :local_systemic_flag => "MyString",
      :maintenance_code => "MyString",
      :form_type_code => "MyString",
      :internal_external_code => "MyString",
      :single_combo_code => "MyString",
      :representative_gpi_flag => "MyString",
      :representative_kdc_flag => "MyString",
      :clarity => "MyString",
      :coating => "MyString",
      :color => "MyString",
      :flavor => "MyString",
      :scored => "MyString",
      :shape => "MyString",
      :image_file_name => "MyString",
      :side1_imprint => "MyString",
      :side2_imprint => "MyString",
      :appearance_text => "MyText",
      :medication_guide_file => "MyString",
      :monitoring_program => "MyString",
      :monitoring_file_name => "MyString",
      :monograph_file_name => "MyString",
      :black_box_file_name => "MyString",
      :contains_acetaminophen => false,
      :contains_pseudoephedrine => false
    ))
  end

  it "renders the edit cdb_drug_reference form" do
    render

    assert_select "form[action=?][method=?]", cdb_drug_reference_path(@cdb_drug_reference), "post" do

      assert_select "input#cdb_drug_reference_ndc_number[name=?]", "cdb_drug_reference[ndc_number]"

      assert_select "input#cdb_drug_reference_ndc_number10[name=?]", "cdb_drug_reference[ndc_number10]"

      assert_select "input#cdb_drug_reference_ddid_number[name=?]", "cdb_drug_reference[ddid_number]"

      assert_select "input#cdb_drug_reference_kdc_code[name=?]", "cdb_drug_reference[kdc_code]"

      assert_select "input#cdb_drug_reference_drug_name[name=?]", "cdb_drug_reference[drug_name]"

      assert_select "input#cdb_drug_reference_generic_product_id[name=?]", "cdb_drug_reference[generic_product_id]"

      assert_select "input#cdb_drug_reference_therapeutic_equivalence_eval_code[name=?]", "cdb_drug_reference[therapeutic_equivalence_eval_code]"

      assert_select "input#cdb_drug_reference_dea_schedule[name=?]", "cdb_drug_reference[dea_schedule]"

      assert_select "input#cdb_drug_reference_desi_code[name=?]", "cdb_drug_reference[desi_code]"

      assert_select "input#cdb_drug_reference_rx_otc_indicator[name=?]", "cdb_drug_reference[rx_otc_indicator]"

      assert_select "input#cdb_drug_reference_generic_packaging_code[name=?]", "cdb_drug_reference[generic_packaging_code]"

      assert_select "input#cdb_drug_reference_previous_ndc_number[name=?]", "cdb_drug_reference[previous_ndc_number]"

      assert_select "input#cdb_drug_reference_new_ndc_number[name=?]", "cdb_drug_reference[new_ndc_number]"

      assert_select "input#cdb_drug_reference_repackage_code[name=?]", "cdb_drug_reference[repackage_code]"

      assert_select "input#cdb_drug_reference_id_number_format[name=?]", "cdb_drug_reference[id_number_format]"

      assert_select "input#cdb_drug_reference_package_size[name=?]", "cdb_drug_reference[package_size]"

      assert_select "input#cdb_drug_reference_package_size_unit_measure[name=?]", "cdb_drug_reference[package_size_unit_measure]"

      assert_select "input#cdb_drug_reference_package_size_quantity[name=?]", "cdb_drug_reference[package_size_quantity]"

      assert_select "input#cdb_drug_reference_mfg_name[name=?]", "cdb_drug_reference[mfg_name]"

      assert_select "input#cdb_drug_reference_third_party_restriction_code[name=?]", "cdb_drug_reference[third_party_restriction_code]"

      assert_select "input#cdb_drug_reference_kdc_flag[name=?]", "cdb_drug_reference[kdc_flag]"

      assert_select "input#cdb_drug_reference_labeler_id_number[name=?]", "cdb_drug_reference[labeler_id_number]"

      assert_select "input#cdb_drug_reference_multi_source_code[name=?]", "cdb_drug_reference[multi_source_code]"

      assert_select "input#cdb_drug_reference_name_type_code[name=?]", "cdb_drug_reference[name_type_code]"

      assert_select "input#cdb_drug_reference_item_status_flag[name=?]", "cdb_drug_reference[item_status_flag]"

      assert_select "input#cdb_drug_reference_innerpack_code[name=?]", "cdb_drug_reference[innerpack_code]"

      assert_select "input#cdb_drug_reference_clinic_pack_code[name=?]", "cdb_drug_reference[clinic_pack_code]"

      assert_select "input#cdb_drug_reference_pharmacy_stocked_indicator[name=?]", "cdb_drug_reference[pharmacy_stocked_indicator]"

      assert_select "input#cdb_drug_reference_hospital_stocked_indicator[name=?]", "cdb_drug_reference[hospital_stocked_indicator]"

      assert_select "input#cdb_drug_reference_dispensing_unit_code[name=?]", "cdb_drug_reference[dispensing_unit_code]"

      assert_select "input#cdb_drug_reference_dollar_rank_code[name=?]", "cdb_drug_reference[dollar_rank_code]"

      assert_select "input#cdb_drug_reference_rx_rank_code[name=?]", "cdb_drug_reference[rx_rank_code]"

      assert_select "input#cdb_drug_reference_storage_code[name=?]", "cdb_drug_reference[storage_code]"

      assert_select "input#cdb_drug_reference_limited_distribution_code[name=?]", "cdb_drug_reference[limited_distribution_code]"

      assert_select "input#cdb_drug_reference_next_smaller_ndc[name=?]", "cdb_drug_reference[next_smaller_ndc]"

      assert_select "input#cdb_drug_reference_next_larger_ndc[name=?]", "cdb_drug_reference[next_larger_ndc]"

      assert_select "input#cdb_drug_reference_awp_unit_price[name=?]", "cdb_drug_reference[awp_unit_price]"

      assert_select "input#cdb_drug_reference_awp_package_price[name=?]", "cdb_drug_reference[awp_package_price]"

      assert_select "input#cdb_drug_reference_direct_unit_price[name=?]", "cdb_drug_reference[direct_unit_price]"

      assert_select "input#cdb_drug_reference_direct_package_price[name=?]", "cdb_drug_reference[direct_package_price]"

      assert_select "input#cdb_drug_reference_wac_unit_price[name=?]", "cdb_drug_reference[wac_unit_price]"

      assert_select "input#cdb_drug_reference_wac_package_price[name=?]", "cdb_drug_reference[wac_package_price]"

      assert_select "input#cdb_drug_reference_federal_mac_unit_price[name=?]", "cdb_drug_reference[federal_mac_unit_price]"

      assert_select "input#cdb_drug_reference_federal_mac_unit_dose[name=?]", "cdb_drug_reference[federal_mac_unit_dose]"

      assert_select "input#cdb_drug_reference_route_of_admin_code[name=?]", "cdb_drug_reference[route_of_admin_code]"

      assert_select "input#cdb_drug_reference_dosage_form[name=?]", "cdb_drug_reference[dosage_form]"

      assert_select "input#cdb_drug_reference_drug_strength[name=?]", "cdb_drug_reference[drug_strength]"

      assert_select "input#cdb_drug_reference_strength_unit_measure[name=?]", "cdb_drug_reference[strength_unit_measure]"

      assert_select "input#cdb_drug_reference_bioequivalence_code[name=?]", "cdb_drug_reference[bioequivalence_code]"

      assert_select "input#cdb_drug_reference_controlled_substance_code[name=?]", "cdb_drug_reference[controlled_substance_code]"

      assert_select "input#cdb_drug_reference_efficacy_code[name=?]", "cdb_drug_reference[efficacy_code]"

      assert_select "input#cdb_drug_reference_legend_indicator[name=?]", "cdb_drug_reference[legend_indicator]"

      assert_select "input#cdb_drug_reference_brand_name_code[name=?]", "cdb_drug_reference[brand_name_code]"

      assert_select "input#cdb_drug_reference_name_source_code[name=?]", "cdb_drug_reference[name_source_code]"

      assert_select "input#cdb_drug_reference_new_ddid_number[name=?]", "cdb_drug_reference[new_ddid_number]"

      assert_select "input#cdb_drug_reference_screenable_flag[name=?]", "cdb_drug_reference[screenable_flag]"

      assert_select "input#cdb_drug_reference_local_systemic_flag[name=?]", "cdb_drug_reference[local_systemic_flag]"

      assert_select "input#cdb_drug_reference_maintenance_code[name=?]", "cdb_drug_reference[maintenance_code]"

      assert_select "input#cdb_drug_reference_form_type_code[name=?]", "cdb_drug_reference[form_type_code]"

      assert_select "input#cdb_drug_reference_internal_external_code[name=?]", "cdb_drug_reference[internal_external_code]"

      assert_select "input#cdb_drug_reference_single_combo_code[name=?]", "cdb_drug_reference[single_combo_code]"

      assert_select "input#cdb_drug_reference_representative_gpi_flag[name=?]", "cdb_drug_reference[representative_gpi_flag]"

      assert_select "input#cdb_drug_reference_representative_kdc_flag[name=?]", "cdb_drug_reference[representative_kdc_flag]"

      assert_select "input#cdb_drug_reference_clarity[name=?]", "cdb_drug_reference[clarity]"

      assert_select "input#cdb_drug_reference_coating[name=?]", "cdb_drug_reference[coating]"

      assert_select "input#cdb_drug_reference_color[name=?]", "cdb_drug_reference[color]"

      assert_select "input#cdb_drug_reference_flavor[name=?]", "cdb_drug_reference[flavor]"

      assert_select "input#cdb_drug_reference_scored[name=?]", "cdb_drug_reference[scored]"

      assert_select "input#cdb_drug_reference_shape[name=?]", "cdb_drug_reference[shape]"

      assert_select "input#cdb_drug_reference_image_file_name[name=?]", "cdb_drug_reference[image_file_name]"

      assert_select "input#cdb_drug_reference_side1_imprint[name=?]", "cdb_drug_reference[side1_imprint]"

      assert_select "input#cdb_drug_reference_side2_imprint[name=?]", "cdb_drug_reference[side2_imprint]"

      assert_select "textarea#cdb_drug_reference_appearance_text[name=?]", "cdb_drug_reference[appearance_text]"

      assert_select "input#cdb_drug_reference_medication_guide_file[name=?]", "cdb_drug_reference[medication_guide_file]"

      assert_select "input#cdb_drug_reference_monitoring_program[name=?]", "cdb_drug_reference[monitoring_program]"

      assert_select "input#cdb_drug_reference_monitoring_file_name[name=?]", "cdb_drug_reference[monitoring_file_name]"

      assert_select "input#cdb_drug_reference_monograph_file_name[name=?]", "cdb_drug_reference[monograph_file_name]"

      assert_select "input#cdb_drug_reference_black_box_file_name[name=?]", "cdb_drug_reference[black_box_file_name]"

      assert_select "input#cdb_drug_reference_contains_acetaminophen[name=?]", "cdb_drug_reference[contains_acetaminophen]"

      assert_select "input#cdb_drug_reference_contains_pseudoephedrine[name=?]", "cdb_drug_reference[contains_pseudoephedrine]"
    end
  end
end
