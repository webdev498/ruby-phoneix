require 'rails_helper'

RSpec.describe "cdb_drug_references/index", type: :view do
  before(:each) do
    assign(:cdb_drug_references, [
      CdbDrugReference.create!(
        :ndc_number => 1,
        :ndc_number10 => 2,
        :ddid_number => 3,
        :kdc_code => 4,
        :drug_name => "Drug Name",
        :generic_product_id => "Generic Product",
        :therapeutic_equivalence_eval_code => "Therapeutic Equivalence Eval Code",
        :dea_schedule => "Dea Schedule",
        :desi_code => "Desi Code",
        :rx_otc_indicator => "Rx Otc Indicator",
        :generic_packaging_code => "Generic Packaging Code",
        :previous_ndc_number => 5,
        :new_ndc_number => 6,
        :repackage_code => "Repackage Code",
        :id_number_format => "Id Number Format",
        :package_size => "9.99",
        :package_size_unit_measure => "Package Size Unit Measure",
        :package_size_quantity => 7,
        :mfg_name => "Mfg Name",
        :third_party_restriction_code => "Third Party Restriction Code",
        :kdc_flag => "Kdc Flag",
        :labeler_id_number => 8,
        :multi_source_code => "Multi Source Code",
        :name_type_code => "Name Type Code",
        :item_status_flag => "Item Status Flag",
        :innerpack_code => "Innerpack Code",
        :clinic_pack_code => "Clinic Pack Code",
        :pharmacy_stocked_indicator => "Pharmacy Stocked Indicator",
        :hospital_stocked_indicator => "Hospital Stocked Indicator",
        :dispensing_unit_code => "Dispensing Unit Code",
        :dollar_rank_code => "Dollar Rank Code",
        :rx_rank_code => "Rx Rank Code",
        :storage_code => "Storage Code",
        :limited_distribution_code => "Limited Distribution Code",
        :next_smaller_ndc => "Next Smaller Ndc",
        :next_larger_ndc => "Next Larger Ndc",
        :awp_unit_price => "9.99",
        :awp_package_price => "9.99",
        :direct_unit_price => "9.99",
        :direct_package_price => "9.99",
        :wac_unit_price => "9.99",
        :wac_package_price => "9.99",
        :federal_mac_unit_price => "9.99",
        :federal_mac_unit_dose => "9.99",
        :route_of_admin_code => "Route Of Admin Code",
        :dosage_form => "Dosage Form",
        :drug_strength => "Drug Strength",
        :strength_unit_measure => "Strength Unit Measure",
        :bioequivalence_code => "Bioequivalence Code",
        :controlled_substance_code => "Controlled Substance Code",
        :efficacy_code => "Efficacy Code",
        :legend_indicator => "Legend Indicator",
        :brand_name_code => "Brand Name Code",
        :name_source_code => "Name Source Code",
        :new_ddid_number => 9,
        :screenable_flag => "Screenable Flag",
        :local_systemic_flag => "Local Systemic Flag",
        :maintenance_code => "Maintenance Code",
        :form_type_code => "Form Type Code",
        :internal_external_code => "Internal External Code",
        :single_combo_code => "Single Combo Code",
        :representative_gpi_flag => "Representative Gpi Flag",
        :representative_kdc_flag => "Representative Kdc Flag",
        :clarity => "Clarity",
        :coating => "Coating",
        :color => "Color",
        :flavor => "Flavor",
        :scored => "Scored",
        :shape => "Shape",
        :image_file_name => "Image File Name",
        :side1_imprint => "Side1 Imprint",
        :side2_imprint => "Side2 Imprint",
        :appearance_text => "MyText",
        :medication_guide_file => "Medication Guide File",
        :monitoring_program => "Monitoring Program",
        :monitoring_file_name => "Monitoring File Name",
        :monograph_file_name => "Monograph File Name",
        :black_box_file_name => "Black Box File Name",
        :contains_acetaminophen => false,
        :contains_pseudoephedrine => false
      ),
      CdbDrugReference.create!(
        :ndc_number => 1,
        :ndc_number10 => 2,
        :ddid_number => 3,
        :kdc_code => 4,
        :drug_name => "Drug Name",
        :generic_product_id => "Generic Product",
        :therapeutic_equivalence_eval_code => "Therapeutic Equivalence Eval Code",
        :dea_schedule => "Dea Schedule",
        :desi_code => "Desi Code",
        :rx_otc_indicator => "Rx Otc Indicator",
        :generic_packaging_code => "Generic Packaging Code",
        :previous_ndc_number => 5,
        :new_ndc_number => 6,
        :repackage_code => "Repackage Code",
        :id_number_format => "Id Number Format",
        :package_size => "9.99",
        :package_size_unit_measure => "Package Size Unit Measure",
        :package_size_quantity => 7,
        :mfg_name => "Mfg Name",
        :third_party_restriction_code => "Third Party Restriction Code",
        :kdc_flag => "Kdc Flag",
        :labeler_id_number => 8,
        :multi_source_code => "Multi Source Code",
        :name_type_code => "Name Type Code",
        :item_status_flag => "Item Status Flag",
        :innerpack_code => "Innerpack Code",
        :clinic_pack_code => "Clinic Pack Code",
        :pharmacy_stocked_indicator => "Pharmacy Stocked Indicator",
        :hospital_stocked_indicator => "Hospital Stocked Indicator",
        :dispensing_unit_code => "Dispensing Unit Code",
        :dollar_rank_code => "Dollar Rank Code",
        :rx_rank_code => "Rx Rank Code",
        :storage_code => "Storage Code",
        :limited_distribution_code => "Limited Distribution Code",
        :next_smaller_ndc => "Next Smaller Ndc",
        :next_larger_ndc => "Next Larger Ndc",
        :awp_unit_price => "9.99",
        :awp_package_price => "9.99",
        :direct_unit_price => "9.99",
        :direct_package_price => "9.99",
        :wac_unit_price => "9.99",
        :wac_package_price => "9.99",
        :federal_mac_unit_price => "9.99",
        :federal_mac_unit_dose => "9.99",
        :route_of_admin_code => "Route Of Admin Code",
        :dosage_form => "Dosage Form",
        :drug_strength => "Drug Strength",
        :strength_unit_measure => "Strength Unit Measure",
        :bioequivalence_code => "Bioequivalence Code",
        :controlled_substance_code => "Controlled Substance Code",
        :efficacy_code => "Efficacy Code",
        :legend_indicator => "Legend Indicator",
        :brand_name_code => "Brand Name Code",
        :name_source_code => "Name Source Code",
        :new_ddid_number => 9,
        :screenable_flag => "Screenable Flag",
        :local_systemic_flag => "Local Systemic Flag",
        :maintenance_code => "Maintenance Code",
        :form_type_code => "Form Type Code",
        :internal_external_code => "Internal External Code",
        :single_combo_code => "Single Combo Code",
        :representative_gpi_flag => "Representative Gpi Flag",
        :representative_kdc_flag => "Representative Kdc Flag",
        :clarity => "Clarity",
        :coating => "Coating",
        :color => "Color",
        :flavor => "Flavor",
        :scored => "Scored",
        :shape => "Shape",
        :image_file_name => "Image File Name",
        :side1_imprint => "Side1 Imprint",
        :side2_imprint => "Side2 Imprint",
        :appearance_text => "MyText",
        :medication_guide_file => "Medication Guide File",
        :monitoring_program => "Monitoring Program",
        :monitoring_file_name => "Monitoring File Name",
        :monograph_file_name => "Monograph File Name",
        :black_box_file_name => "Black Box File Name",
        :contains_acetaminophen => false,
        :contains_pseudoephedrine => false
      )
    ])
  end

  it "renders a list of cdb_drug_references" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Drug Name".to_s, :count => 2
    assert_select "tr>td", :text => "Generic Product".to_s, :count => 2
    assert_select "tr>td", :text => "Therapeutic Equivalence Eval Code".to_s, :count => 2
    assert_select "tr>td", :text => "Dea Schedule".to_s, :count => 2
    assert_select "tr>td", :text => "Desi Code".to_s, :count => 2
    assert_select "tr>td", :text => "Rx Otc Indicator".to_s, :count => 2
    assert_select "tr>td", :text => "Generic Packaging Code".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Repackage Code".to_s, :count => 2
    assert_select "tr>td", :text => "Id Number Format".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Package Size Unit Measure".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Mfg Name".to_s, :count => 2
    assert_select "tr>td", :text => "Third Party Restriction Code".to_s, :count => 2
    assert_select "tr>td", :text => "Kdc Flag".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => "Multi Source Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name Type Code".to_s, :count => 2
    assert_select "tr>td", :text => "Item Status Flag".to_s, :count => 2
    assert_select "tr>td", :text => "Innerpack Code".to_s, :count => 2
    assert_select "tr>td", :text => "Clinic Pack Code".to_s, :count => 2
    assert_select "tr>td", :text => "Pharmacy Stocked Indicator".to_s, :count => 2
    assert_select "tr>td", :text => "Hospital Stocked Indicator".to_s, :count => 2
    assert_select "tr>td", :text => "Dispensing Unit Code".to_s, :count => 2
    assert_select "tr>td", :text => "Dollar Rank Code".to_s, :count => 2
    assert_select "tr>td", :text => "Rx Rank Code".to_s, :count => 2
    assert_select "tr>td", :text => "Storage Code".to_s, :count => 2
    assert_select "tr>td", :text => "Limited Distribution Code".to_s, :count => 2
    assert_select "tr>td", :text => "Next Smaller Ndc".to_s, :count => 2
    assert_select "tr>td", :text => "Next Larger Ndc".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Route Of Admin Code".to_s, :count => 2
    assert_select "tr>td", :text => "Dosage Form".to_s, :count => 2
    assert_select "tr>td", :text => "Drug Strength".to_s, :count => 2
    assert_select "tr>td", :text => "Strength Unit Measure".to_s, :count => 2
    assert_select "tr>td", :text => "Bioequivalence Code".to_s, :count => 2
    assert_select "tr>td", :text => "Controlled Substance Code".to_s, :count => 2
    assert_select "tr>td", :text => "Efficacy Code".to_s, :count => 2
    assert_select "tr>td", :text => "Legend Indicator".to_s, :count => 2
    assert_select "tr>td", :text => "Brand Name Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name Source Code".to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => "Screenable Flag".to_s, :count => 2
    assert_select "tr>td", :text => "Local Systemic Flag".to_s, :count => 2
    assert_select "tr>td", :text => "Maintenance Code".to_s, :count => 2
    assert_select "tr>td", :text => "Form Type Code".to_s, :count => 2
    assert_select "tr>td", :text => "Internal External Code".to_s, :count => 2
    assert_select "tr>td", :text => "Single Combo Code".to_s, :count => 2
    assert_select "tr>td", :text => "Representative Gpi Flag".to_s, :count => 2
    assert_select "tr>td", :text => "Representative Kdc Flag".to_s, :count => 2
    assert_select "tr>td", :text => "Clarity".to_s, :count => 2
    assert_select "tr>td", :text => "Coating".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => "Flavor".to_s, :count => 2
    assert_select "tr>td", :text => "Scored".to_s, :count => 2
    assert_select "tr>td", :text => "Shape".to_s, :count => 2
    assert_select "tr>td", :text => "Image File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Side1 Imprint".to_s, :count => 2
    assert_select "tr>td", :text => "Side2 Imprint".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Medication Guide File".to_s, :count => 2
    assert_select "tr>td", :text => "Monitoring Program".to_s, :count => 2
    assert_select "tr>td", :text => "Monitoring File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Monograph File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Black Box File Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
