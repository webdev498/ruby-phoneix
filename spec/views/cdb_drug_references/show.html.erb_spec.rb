require 'rails_helper'

RSpec.describe "cdb_drug_references/show", type: :view do
  before(:each) do
    @cdb_drug_reference = assign(:cdb_drug_reference, CdbDrugReference.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Drug Name/)
    expect(rendered).to match(/Generic Product/)
    expect(rendered).to match(/Therapeutic Equivalence Eval Code/)
    expect(rendered).to match(/Dea Schedule/)
    expect(rendered).to match(/Desi Code/)
    expect(rendered).to match(/Rx Otc Indicator/)
    expect(rendered).to match(/Generic Packaging Code/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Repackage Code/)
    expect(rendered).to match(/Id Number Format/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Package Size Unit Measure/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/Mfg Name/)
    expect(rendered).to match(/Third Party Restriction Code/)
    expect(rendered).to match(/Kdc Flag/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/Multi Source Code/)
    expect(rendered).to match(/Name Type Code/)
    expect(rendered).to match(/Item Status Flag/)
    expect(rendered).to match(/Innerpack Code/)
    expect(rendered).to match(/Clinic Pack Code/)
    expect(rendered).to match(/Pharmacy Stocked Indicator/)
    expect(rendered).to match(/Hospital Stocked Indicator/)
    expect(rendered).to match(/Dispensing Unit Code/)
    expect(rendered).to match(/Dollar Rank Code/)
    expect(rendered).to match(/Rx Rank Code/)
    expect(rendered).to match(/Storage Code/)
    expect(rendered).to match(/Limited Distribution Code/)
    expect(rendered).to match(/Next Smaller Ndc/)
    expect(rendered).to match(/Next Larger Ndc/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Route Of Admin Code/)
    expect(rendered).to match(/Dosage Form/)
    expect(rendered).to match(/Drug Strength/)
    expect(rendered).to match(/Strength Unit Measure/)
    expect(rendered).to match(/Bioequivalence Code/)
    expect(rendered).to match(/Controlled Substance Code/)
    expect(rendered).to match(/Efficacy Code/)
    expect(rendered).to match(/Legend Indicator/)
    expect(rendered).to match(/Brand Name Code/)
    expect(rendered).to match(/Name Source Code/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/Screenable Flag/)
    expect(rendered).to match(/Local Systemic Flag/)
    expect(rendered).to match(/Maintenance Code/)
    expect(rendered).to match(/Form Type Code/)
    expect(rendered).to match(/Internal External Code/)
    expect(rendered).to match(/Single Combo Code/)
    expect(rendered).to match(/Representative Gpi Flag/)
    expect(rendered).to match(/Representative Kdc Flag/)
    expect(rendered).to match(/Clarity/)
    expect(rendered).to match(/Coating/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/Flavor/)
    expect(rendered).to match(/Scored/)
    expect(rendered).to match(/Shape/)
    expect(rendered).to match(/Image File Name/)
    expect(rendered).to match(/Side1 Imprint/)
    expect(rendered).to match(/Side2 Imprint/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Medication Guide File/)
    expect(rendered).to match(/Monitoring Program/)
    expect(rendered).to match(/Monitoring File Name/)
    expect(rendered).to match(/Monograph File Name/)
    expect(rendered).to match(/Black Box File Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
