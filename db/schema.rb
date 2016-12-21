# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161220164551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_postings", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "account_id"
    t.integer  "master_account_number"
    t.integer  "account_number"
    t.date     "post_date"
    t.integer  "post_ticket"
    t.integer  "post_ticket_sequence"
    t.integer  "post_payor_id"
    t.integer  "post_source"
    t.integer  "post_type"
    t.string   "post_description",        limit: 20
    t.decimal  "post_medical_amount",                precision: 9, scale: 2
    t.decimal  "post_non_medical_amount",            precision: 9, scale: 2
    t.decimal  "post_tax_amount",                    precision: 6, scale: 2
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "account_postings", ["account_id"], name: "index_account_postings_on_account_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "plan_id_code"
    t.integer  "facility_id"
    t.integer  "account_payor_id"
    t.integer  "account_sponsor_id"
    t.integer  "account_number"
    t.integer  "master_account_number"
    t.integer  "accounting_method"
    t.integer  "payor_type"
    t.integer  "legacy_customer_id_number"
    t.integer  "legacy_sponsor_id_number"
    t.boolean  "allow_otc_charges"
    t.boolean  "active"
    t.integer  "print_statement"
    t.date     "date_opened"
    t.date     "last_statement_date"
    t.date     "last_charge_date"
    t.date     "last_payment_date"
    t.date     "last_past_due_date"
    t.date     "past_due_letter_sent"
    t.decimal  "current_period_amount",                         precision: 11, scale: 2
    t.decimal  "last_period_amount",                            precision: 11, scale: 2
    t.decimal  "high_balance_amount",                           precision: 11, scale: 2
    t.decimal  "high_past_due_amount",                          precision: 11, scale: 2
    t.decimal  "over_30_amount",                                precision: 11, scale: 2
    t.decimal  "over_60_amount",                                precision: 11, scale: 2
    t.decimal  "over_90_amount",                                precision: 11, scale: 2
    t.integer  "number_times_past_30"
    t.integer  "number_times_past_60"
    t.integer  "number_times_past_90"
    t.decimal  "last_charge_amount",                            precision: 11, scale: 2
    t.decimal  "last_payment_amount",                           precision: 11, scale: 2
    t.decimal  "last_statement_balance",                        precision: 11, scale: 2
    t.decimal  "tax_deductible_amount_year_to_date",            precision: 11, scale: 2
    t.decimal  "non_deductible_amount_year_to_date",            precision: 11, scale: 2
    t.decimal  "finance_charges_year_to_date",                  precision: 8,  scale: 2
    t.decimal  "tax_paid_year_to_date",                         precision: 8,  scale: 2
    t.decimal  "credit_limit",                                  precision: 10, scale: 2
    t.decimal  "finance_charge_percentage1",                    precision: 3,  scale: 3
    t.decimal  "finance_charge_percentage2",                    precision: 3,  scale: 3
    t.decimal  "finance_percentage1_limit",                     precision: 7,  scale: 2
    t.decimal  "terms_rate",                                    precision: 3,  scale: 3
    t.decimal  "terms_amount",                                  precision: 7,  scale: 2
    t.string   "memo",                               limit: 30
    t.text     "notes"
    t.integer  "rx_charge_description"
    t.integer  "statement_type"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "prescriber_id"
    t.integer  "kind"
    t.integer  "use"
    t.integer  "rank"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "postal"
    t.string   "country"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.uuid     "uuid"
    t.boolean  "active"
    t.string   "alert_source"
    t.string   "event_type"
    t.datetime "event_time"
    t.string   "severity"
    t.string   "message"
    t.boolean  "viewed"
    t.string   "viewed_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "beds", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "facility_id"
    t.integer  "wing_id"
    t.integer  "residency_id"
    t.integer  "customer_id"
    t.integer  "legacy_customer_id_number"
    t.boolean  "active"
    t.integer  "pass_order"
    t.string   "bed",                       limit: 8
    t.string   "bed_type",                  limit: 20
    t.date     "occupancy_date"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "beds", ["customer_id"], name: "index_beds_on_customer_id", using: :btree
  add_index "beds", ["facility_id"], name: "index_beds_on_facility_id", using: :btree
  add_index "beds", ["residency_id"], name: "index_beds_on_residency_id", using: :btree
  add_index "beds", ["wing_id"], name: "index_beds_on_wing_id", using: :btree

  create_table "cdb_allergen_formulations", force: :cascade do |t|
    t.string   "record_type", limit: 3
    t.integer  "kdc1_code"
    t.integer  "drug_class",                         array: true
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "cdb_allergens", force: :cascade do |t|
    t.integer  "code"
    t.string   "description", limit: 72
    t.boolean  "ingredient"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cdb_diagnoses", force: :cascade do |t|
    t.string   "diagnosis_type",  limit: 1
    t.string   "icd_code",        limit: 20
    t.string   "icd_description", limit: 100
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "cdb_diagnosis_xrefs", force: :cascade do |t|
    t.integer  "medical_condition_code"
    t.string   "diagnosis_type",         limit: 1
    t.string   "icd_code",               limit: 20
    t.boolean  "condition_to_icd"
    t.boolean  "icd_to_condition"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cdb_disease_xrefs", force: :cascade do |t|
    t.integer  "medical_condition_code"
    t.integer  "disease_code"
    t.boolean  "condition_to_disease"
    t.boolean  "disease_to_condition"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cdb_drug_references", force: :cascade do |t|
    t.integer  "ndc_number",                            limit: 8
    t.integer  "ndc_number10",                          limit: 8
    t.integer  "ddid_number"
    t.integer  "kdc_code",                              limit: 8
    t.string   "drug_name",                             limit: 30
    t.string   "generic_product_id",                    limit: 14
    t.string   "therapeutic_equivalence_eval_code",     limit: 2
    t.string   "dea_schedule",                          limit: 1
    t.string   "desi_code",                             limit: 1
    t.string   "rx_otc_indicator",                      limit: 1
    t.string   "generic_packaging_code",                limit: 8
    t.integer  "previous_ndc_number",                   limit: 8
    t.integer  "new_ndc_number",                        limit: 8
    t.string   "repackage_code",                        limit: 1
    t.string   "id_number_format",                      limit: 1
    t.decimal  "package_size",                                     precision: 9,  scale: 3
    t.string   "package_size_unit_measure",             limit: 2
    t.integer  "package_size_quantity"
    t.string   "mfg_name",                              limit: 10
    t.string   "third_party_restriction_code",          limit: 1
    t.string   "kdc_flag",                              limit: 1
    t.integer  "labeler_id_number"
    t.string   "multi_source_code",                     limit: 1
    t.string   "name_type_code",                        limit: 1
    t.string   "item_status_flag",                      limit: 1
    t.string   "innerpack_code",                        limit: 1
    t.string   "clinic_pack_code",                      limit: 1
    t.string   "pharmacy_stocked_indicator",            limit: 1
    t.string   "hospital_stocked_indicator",            limit: 1
    t.string   "dispensing_unit_code",                  limit: 1
    t.string   "dollar_rank_code",                      limit: 1
    t.string   "rx_rank_code",                          limit: 1
    t.string   "storage_code",                          limit: 1
    t.string   "limited_distribution_code",             limit: 2
    t.date     "old_ndc_effective_date"
    t.date     "new_ndc_effective_date"
    t.string   "next_smaller_ndc",                      limit: 2
    t.string   "next_larger_ndc",                       limit: 2
    t.date     "last_change_date"
    t.decimal  "awp_unit_price",                                   precision: 11, scale: 6
    t.decimal  "awp_package_price",                                precision: 10, scale: 2
    t.date     "awp_last_change_date"
    t.decimal  "direct_unit_price",                                precision: 11, scale: 6
    t.decimal  "direct_package_price",                             precision: 10, scale: 2
    t.date     "direct_last_change_date"
    t.decimal  "wac_unit_price",                                   precision: 11, scale: 6
    t.decimal  "wac_package_price",                                precision: 10, scale: 2
    t.date     "wac_last_change_date"
    t.decimal  "federal_mac_unit_price",                           precision: 11, scale: 6
    t.date     "federal_mac_last_change_date"
    t.decimal  "federal_mac_unit_dose",                            precision: 11, scale: 6
    t.date     "federal_mac_unitdose_last_change_date"
    t.string   "route_of_admin_code",                   limit: 2
    t.string   "dosage_form",                           limit: 4
    t.string   "drug_strength",                         limit: 15
    t.string   "strength_unit_measure",                 limit: 10
    t.string   "bioequivalence_code",                   limit: 1
    t.string   "controlled_substance_code",             limit: 1
    t.string   "efficacy_code",                         limit: 1
    t.string   "legend_indicator",                      limit: 1
    t.string   "brand_name_code",                       limit: 1
    t.string   "name_source_code",                      limit: 1
    t.integer  "new_ddid_number"
    t.string   "screenable_flag",                       limit: 1
    t.string   "local_systemic_flag",                   limit: 1
    t.string   "maintenance_code",                      limit: 1
    t.string   "form_type_code",                        limit: 1
    t.string   "internal_external_code",                limit: 1
    t.string   "single_combo_code",                     limit: 1
    t.string   "representative_gpi_flag",               limit: 1
    t.string   "representative_kdc_flag",               limit: 1
    t.string   "clarity",                               limit: 30
    t.string   "coating",                               limit: 30
    t.string   "color",                                 limit: 30
    t.string   "flavor",                                limit: 30
    t.string   "scored",                                limit: 30
    t.string   "shape",                                 limit: 30
    t.string   "image_file_name",                       limit: 20
    t.string   "side1_imprint",                         limit: 40
    t.string   "side2_imprint",                         limit: 40
    t.text     "appearance_text"
    t.string   "medication_guide_file",                 limit: 10
    t.string   "monitoring_program",                    limit: 1
    t.string   "monitoring_file_name",                  limit: 13
    t.string   "monograph_file_name"
    t.string   "black_box_file_name",                   limit: 30
    t.boolean  "contains_acetaminophen"
    t.boolean  "contains_pseudoephedrine"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  add_index "cdb_drug_references", ["drug_name"], name: "index_cdb_drug_references_on_drug_name", using: :btree
  add_index "cdb_drug_references", ["generic_product_id"], name: "index_cdb_drug_references_on_generic_product_id", using: :btree
  add_index "cdb_drug_references", ["ndc_number"], name: "index_cdb_drug_references_on_ndc_number", using: :btree
  add_index "cdb_drug_references", ["ndc_number10"], name: "index_cdb_drug_references_on_ndc_number10", using: :btree

  create_table "cdb_indications", force: :cascade do |t|
    t.string   "generic_product_identifier",      limit: 14
    t.integer  "medical_condition_restrict_code"
    t.integer  "indicated_medical_condition"
    t.integer  "microorganism_code"
    t.integer  "role_of_therapy_code"
    t.integer  "outcome_code"
    t.integer  "treatment_rank_code"
    t.integer  "acceptance_level"
    t.integer  "proxy_code"
    t.integer  "proxy_only"
    t.integer  "text_type_code"
    t.integer  "text_code",                       limit: 8
    t.text     "text_description"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "cdb_interaction_formulations", force: :cascade do |t|
    t.string   "record_type", limit: 3
    t.integer  "kdc1_code"
    t.integer  "drug_class",                         array: true
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "cdb_interaction_texts", force: :cascade do |t|
    t.integer  "class_number1"
    t.integer  "class_number2"
    t.integer  "interacting_drugs",                         array: true
    t.string   "class_name1",       limit: 72
    t.string   "class_name2",       limit: 72
    t.text     "warning"
    t.text     "effects"
    t.text     "mechanism"
    t.text     "management"
    t.text     "discussion"
    t.text     "reference"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "cdb_interactions", force: :cascade do |t|
    t.string   "record_type",                         limit: 3
    t.integer  "sub_type"
    t.integer  "primary_class"
    t.integer  "primary_duration"
    t.boolean  "primary_regular_schedule"
    t.boolean  "primary_prn_schedule"
    t.boolean  "primary_one_time"
    t.integer  "primary_class_name_length"
    t.integer  "primary_class_number_interactions"
    t.integer  "secondary_class"
    t.integer  "secondary_duration"
    t.boolean  "secondary_regular_schedule"
    t.boolean  "secondary_prn_schedule"
    t.boolean  "secondary_one_time"
    t.integer  "secondary_class_name_length"
    t.integer  "secondary_class_number_interactions"
    t.integer  "unique_pair_id"
    t.integer  "onset_code"
    t.integer  "severity_code"
    t.integer  "documentation"
    t.integer  "management_code"
    t.integer  "activity_code1"
    t.integer  "activity_code2"
    t.integer  "contraindications_code"
    t.integer  "warning_text_length"
    t.integer  "effects_text_length"
    t.integer  "mechanism_text_length"
    t.integer  "management_text_length"
    t.integer  "discussion_text_length"
    t.integer  "reference_text_length"
    t.string   "interaction_type",                    limit: 1
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "cdb_kdc_xrefs", force: :cascade do |t|
    t.integer  "ndc_number", limit: 8
    t.integer  "kdc1_code"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "cdb_medical_conditions", force: :cascade do |t|
    t.integer  "medical_condition_code"
    t.string   "condition_name",         limit: 58
    t.integer  "condition_type"
    t.boolean  "classification_only"
    t.string   "gender",                 limit: 1
    t.boolean  "pregnancy"
    t.boolean  "lactation"
    t.integer  "from_age"
    t.integer  "through_age"
    t.string   "age_units_code",         limit: 1
    t.integer  "duration_code"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cdb_monographs", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "base_file_name",         limit: 30
    t.string   "drug_name",              limit: 40
    t.text     "pronunciation"
    t.text     "us_brand_name"
    t.text     "canadian_brand_name"
    t.text     "warning"
    t.text     "used_for"
    t.text     "before_use"
    t.text     "during_use"
    t.text     "primary_side_effects"
    t.text     "secondary_side_effects"
    t.text     "best_taken"
    t.text     "missed_dose"
    t.text     "storage_discarding"
    t.text     "general_facts"
    t.text     "disclaimer"
    t.text     "copyright"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cdb_precaution_texts", force: :cascade do |t|
    t.string   "generic_product_id",                 limit: 14
    t.integer  "medical_condition_restriction_code"
    t.integer  "precaution_condition_code"
    t.integer  "from_age"
    t.integer  "thru_age"
    t.integer  "age_units"
    t.integer  "text_type_code"
    t.integer  "text_code",                          limit: 8
    t.integer  "level_code"
    t.text     "text_data"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "cdb_precautions", force: :cascade do |t|
    t.string   "generic_product_id",         limit: 14
    t.integer  "condition_restriction_code"
    t.integer  "condition_code"
    t.integer  "from_age"
    t.integer  "thru_age"
    t.integer  "age_units"
    t.integer  "severity"
    t.integer  "placental_transfer"
    t.integer  "fda_risk"
    t.integer  "breast_feeding_excretion"
    t.integer  "breast_feeding_rating"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "cdb_prior_adverses", force: :cascade do |t|
    t.string   "record_type",                   limit: 3
    t.integer  "sub_type"
    t.integer  "primary_class"
    t.integer  "reacting_class"
    t.boolean  "symptom_rash"
    t.boolean  "symptom_shock_unconscious"
    t.boolean  "symptom_asthma"
    t.boolean  "symptom_nausea_vomit_diarrhea"
    t.boolean  "symptom_anemia"
    t.boolean  "symptom_unspecified"
    t.integer  "reacting_drug",                                        array: true
    t.text     "primary_class_name"
    t.text     "reacting_class_name"
    t.text     "prior_reaction_heading_text"
    t.text     "reacting_heading_text"
    t.text     "discussion_text"
    t.text     "reference_text"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "cdb_snomeds", force: :cascade do |t|
    t.integer  "medical_condition_code"
    t.string   "snomed_code",            limit: 18
    t.string   "relationship_code",      limit: 2
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "cdb_therapeutics", force: :cascade do |t|
    t.string   "class_key",        limit: 14
    t.string   "record_type",      limit: 1
    t.string   "class_name",       limit: 60
    t.string   "class_level_code", limit: 2
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "claim_clinicals", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "dispense_id"
    t.integer  "rx_number"
    t.integer  "plan_id_code"
    t.integer  "diagnosis_counter"
    t.integer  "diagnosis_code_qualifier"
    t.string   "diagnosis_code",           limit: 15
    t.integer  "clinical_counter"
    t.date     "clinical_date"
    t.string   "clinical_dimension",       limit: 2
    t.integer  "clinical_time"
    t.string   "clinical_unit",            limit: 2
    t.string   "clinical_value",           limit: 15
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "claim_clinicals", ["claim_id"], name: "index_claim_clinicals_on_claim_id", using: :btree
  add_index "claim_clinicals", ["dispense_id"], name: "index_claim_clinicals_on_dispense_id", using: :btree

  create_table "claim_cob_responses", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "plan_id_code"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "other_payor_count"
    t.string   "payor_coverage_type",            limit: 2
    t.integer  "payor_id_qualifier"
    t.string   "payor_id",                       limit: 10
    t.string   "payor_processor_control_number", limit: 10
    t.string   "payor_card_id_number",           limit: 20
    t.string   "payor_group_number",             limit: 18
    t.string   "payor_person_code",              limit: 2
    t.string   "payor_phone_number",             limit: 18
    t.string   "payor_relation_code",            limit: 1
    t.date     "payor_effective_date"
    t.date     "payor_expiration_date"
    t.integer  "payor_benefit_count"
    t.string   "payor_benefit_qualifier",        limit: 2
    t.decimal  "payor_benefit_amount",                      precision: 8, scale: 2
    t.decimal  "payor_coverage_gap",                        precision: 8, scale: 2
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  add_index "claim_cob_responses", ["claim_id"], name: "index_claim_cob_responses_on_claim_id", using: :btree

  create_table "claim_cobs", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "plan_id_code"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "payor_count"
    t.string   "payor_coverage_type",      limit: 2
    t.integer  "payor_id_qualifier"
    t.string   "payor_id",                 limit: 10
    t.date     "payor_date"
    t.integer  "payor_reject_count"
    t.string   "payor_reject_code",                                                        array: true
    t.integer  "payor_paid_count"
    t.string   "payor_paid_qualifier",     limit: 2
    t.decimal  "payor_amount_paid",                   precision: 9, scale: 2
    t.integer  "patient_amount_qualifier"
    t.decimal  "patient_amount",                      precision: 9, scale: 2
    t.string   "benefit_qualifier",        limit: 2
    t.decimal  "benefit_amount",                      precision: 9, scale: 2
    t.string   "control_number",           limit: 30
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "claim_cobs", ["claim_id"], name: "index_claim_cobs_on_claim_id", using: :btree

  create_table "claim_coupons", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "rx_number"
    t.integer  "plan_id_code"
    t.string   "coupon_number", limit: 15
    t.integer  "coupon_type"
    t.decimal  "coupon_amount",            precision: 8, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "claim_coupons", ["claim_id"], name: "index_claim_coupons_on_claim_id", using: :btree

  create_table "claim_durs", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "plan_id_code"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.boolean  "overflow_flag"
    t.integer  "sent_counter"
    t.string   "reason_for_service", limit: 2
    t.string   "result_code",        limit: 2
    t.string   "service_code",       limit: 2
    t.integer  "level_of_effort",    limit: 2
    t.string   "coagent_id",         limit: 19
    t.string   "coagent_qualifier",  limit: 2
    t.integer  "receive_counter"
    t.string   "dur_code",           limit: 2
    t.string   "dur_severity",       limit: 1
    t.string   "dur_pharmacy",       limit: 1
    t.date     "dur_date"
    t.decimal  "dur_quantity",                  precision: 10, scale: 3
    t.string   "dur_database",       limit: 1
    t.integer  "dur_prescriber",     limit: 2
    t.string   "dur_message",        limit: 30
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "claim_durs", ["claim_id"], name: "index_claim_durs_on_claim_id", using: :btree

  create_table "claim_errors", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "plan_id_code"
    t.integer  "error_type"
    t.string   "error_code",   limit: 3
    t.text     "error_text"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "claim_preferences", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "plan_id_code"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "product_count",           limit: 2
    t.decimal  "product_copay_incentive",            precision: 8, scale: 2
    t.decimal  "product_incentive",                  precision: 8, scale: 2
    t.string   "product_name",            limit: 40
    t.string   "product_id_number",       limit: 19
    t.integer  "product_qualifier"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "claim_preferences", ["claim_id"], name: "index_claim_preferences_on_claim_id", using: :btree

  create_table "claim_prior_auths", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "claim_id"
    t.integer  "rx_number"
    t.integer  "plan_id_code"
    t.integer  "authorization_number",       limit: 8
    t.integer  "authorization_basis"
    t.date     "effective_date"
    t.date     "expiration_date"
    t.integer  "request_type"
    t.string   "representative_first_name",  limit: 12
    t.string   "representative_last_name",   limit: 15
    t.string   "representative_address",     limit: 30
    t.string   "representative_city",        limit: 30
    t.string   "representative_state",       limit: 2
    t.string   "representative_zip_code",    limit: 10
    t.text     "supporting_text"
    t.decimal  "response_amount_authorized",            precision: 8,  scale: 2
    t.date     "response_effective_date"
    t.date     "response_expiration_date"
    t.integer  "refills_authorized"
    t.date     "response_processed_date"
    t.decimal  "quantity_authorized",                   precision: 10, scale: 3
    t.decimal  "quantity_accumulated",                  precision: 10, scale: 3
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "claim_prior_auths", ["claim_id"], name: "index_claim_prior_auths_on_claim_id", using: :btree

  create_table "claims", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "prescription_id"
    t.integer  "dispense_id"
    t.integer  "plan_id"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "plan_id_code"
    t.datetime "transmit_time"
    t.integer  "status"
    t.integer  "legacy_customer_id_number"
    t.boolean  "active"
    t.string   "version",                        limit: 2
    t.integer  "transmission_code"
    t.string   "authorization_number",           limit: 20
    t.boolean  "exceeds_percent"
    t.boolean  "dur_on_file"
    t.date     "date_filled"
    t.integer  "eligibility_override"
    t.integer  "origin_override"
    t.decimal  "usual_customary_price",                     precision: 8,  scale: 2
    t.integer  "level_of_service"
    t.string   "primary_prescriber_dea_number",  limit: 10
    t.integer  "cost_basis"
    t.decimal  "total_submitted",                           precision: 8,  scale: 2
    t.decimal  "metric_decimal_quantity",                   precision: 10, scale: 3
    t.integer  "product_type"
    t.string   "product_code",                   limit: 13
    t.decimal  "incentive_amount",                          precision: 8,  scale: 2
    t.decimal  "cost_submitted",                            precision: 8,  scale: 2
    t.decimal  "fee_submitted",                             precision: 8,  scale: 2
    t.integer  "percentage_tax_basis_submitted"
    t.decimal  "tax_submitted",                             precision: 8,  scale: 2
    t.string   "communications_error_code",      limit: 3
    t.string   "header_response",                limit: 1
    t.string   "new_plan_number",                limit: 8
    t.decimal  "cost_paid",                                 precision: 8,  scale: 2
    t.decimal  "contract_fee",                              precision: 8,  scale: 2
    t.decimal  "tax_paid",                                  precision: 8,  scale: 2
    t.decimal  "total_paid",                                precision: 8,  scale: 2
    t.decimal  "accumulated_deductible",                    precision: 8,  scale: 2
    t.decimal  "deductible_left",                           precision: 8,  scale: 2
    t.decimal  "benefit_left",                              precision: 8,  scale: 2
    t.decimal  "amount_to_deductible",                      precision: 8,  scale: 2
    t.decimal  "copay_amount",                              precision: 8,  scale: 2
    t.decimal  "amount_for_product_selection",              precision: 8,  scale: 2
    t.decimal  "exceeds_benefit_amount",                    precision: 8,  scale: 2
    t.decimal  "incentive_fee_paid",                        precision: 8,  scale: 2
    t.decimal  "service_fee_paid",                          precision: 8,  scale: 2
    t.decimal  "other_amount_fee_paid",                     precision: 8,  scale: 2
    t.decimal  "other_payor_amount_recognized",             precision: 8,  scale: 2
    t.decimal  "amount_attributed_to_tax",                  precision: 8,  scale: 2
    t.decimal  "partial_copay_amount",                      precision: 8,  scale: 2
    t.integer  "reimbursement_basis"
    t.decimal  "percent_amount_tax_paid",                   precision: 8,  scale: 2
    t.decimal  "tax_rate_paid",                             precision: 7,  scale: 4
    t.integer  "tax_basis_paid"
    t.string   "help_desk_phone_number",         limit: 18
    t.integer  "approved_message_count"
    t.string   "approved_message_code",                                                           array: true
    t.string   "network_reimbursement_id",       limit: 10
    t.integer  "reject_count"
    t.string   "reject_code",                                                                     array: true
    t.integer  "reject_field_submitted",                                                          array: true
    t.text     "transmission_message"
    t.integer  "other_coverage_code"
    t.integer  "denial_code",                                                                     array: true
    t.string   "route_of_administration",        limit: 11
    t.decimal  "amount_processing_fee",                     precision: 6,  scale: 2
    t.decimal  "response_amount_coinsurance",               precision: 8,  scale: 2
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "claims", ["customer_id"], name: "index_claims_on_customer_id", using: :btree
  add_index "claims", ["dispense_id"], name: "index_claims_on_dispense_id", using: :btree
  add_index "claims", ["plan_id"], name: "index_claims_on_plan_id", using: :btree
  add_index "claims", ["prescription_id"], name: "index_claims_on_prescription_id", using: :btree

  create_table "contact_points", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "prescriber_id"
    t.integer  "kind"
    t.integer  "use"
    t.integer  "rank"
    t.string   "contact"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "customer_allergies", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "legacy_customer_id_number"
    t.integer  "allergy_code"
    t.integer  "allergy_type"
    t.string   "allergy_description",       limit: 50
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "customer_allergies", ["customer_id"], name: "index_customer_allergies_on_customer_id", using: :btree

  create_table "customer_diagnoses", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.string   "diagnosis_code",        limit: 8
    t.string   "diagnosis_description", limit: 100
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "customer_diagnoses", ["customer_id"], name: "index_customer_diagnoses_on_customer_id", using: :btree

  create_table "customer_plans", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "legacy_customer_id_number"
    t.integer  "plan_id_code"
    t.integer  "sequence_number"
    t.integer  "plan_type"
    t.string   "plan_abb_name",              limit: 6
    t.boolean  "active"
    t.date     "effective_date"
    t.date     "expiration_date"
    t.string   "prior_authorization",        limit: 15
    t.integer  "prior_authorization_type"
    t.string   "first_name",                 limit: 12
    t.string   "last_name",                  limit: 15
    t.string   "card_number",                limit: 20
    t.string   "plan_number",                limit: 8
    t.string   "group_number",               limit: 20
    t.string   "person_code",                limit: 3
    t.integer  "relationship_code"
    t.boolean  "other_insurance_code"
    t.boolean  "pending"
    t.string   "home_plan",                  limit: 3
    t.integer  "eligibility_code"
    t.string   "employee_id_number",         limit: 15
    t.string   "universal_id_number",        limit: 20
    t.string   "universal_id_type",          limit: 2
    t.string   "cardholder_first_name",      limit: 12
    t.string   "cardholder_last_name",       limit: 15
    t.string   "facility_id_number",         limit: 10
    t.integer  "location_code"
    t.integer  "limit_of_rx"
    t.integer  "current_number_rx"
    t.decimal  "current_amount",                        precision: 7, scale: 2
    t.integer  "ytd_number_rx"
    t.decimal  "ytd_amount",                            precision: 7, scale: 2
    t.date     "date_of_injury"
    t.string   "medigap_id_number",          limit: 20
    t.string   "state_medicaid",             limit: 2
    t.string   "medicaid_id_number",         limit: 20
    t.string   "employer_name",              limit: 30
    t.string   "employer_address",           limit: 30
    t.string   "employer_city",              limit: 30
    t.string   "employer_state",             limit: 2
    t.string   "employer_zip_code",          limit: 10
    t.string   "employer_phone",             limit: 15
    t.string   "employer_contact",           limit: 30
    t.string   "employer_carrier_id_number", limit: 10
    t.string   "employer_claim_number",      limit: 30
    t.integer  "carrier_id_number"
    t.integer  "assist_drug_ndc",            limit: 8
    t.decimal  "brand_name_copay",                      precision: 7, scale: 2
    t.decimal  "generic_drug_copay",                    precision: 7, scale: 2
    t.decimal  "brand_name_copay_pct",                  precision: 3, scale: 2
    t.decimal  "generic_copay_pct",                     precision: 3, scale: 2
    t.decimal  "ytd_copay",                             precision: 7, scale: 2
    t.decimal  "ytd_copay_limit",                       precision: 7, scale: 2
    t.decimal  "fixed_copay",                           precision: 7, scale: 2
    t.decimal  "higher_copay",                          precision: 7, scale: 2
    t.decimal  "begin_range",                           precision: 7, scale: 2
    t.integer  "account_number"
    t.integer  "master_account_number"
    t.integer  "accounting_method"
    t.integer  "payor_type"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "customer_plans", ["customer_id"], name: "index_customer_plans_on_customer_id", using: :btree

  create_table "customer_wellnesses", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.boolean  "active"
    t.boolean  "scripted_calls"
    t.integer  "receive_messages"
    t.boolean  "medication_passtime_alerts"
    t.boolean  "illness_monitoring"
    t.boolean  "customer_remote_access"
    t.date     "last_customer_access"
    t.integer  "receive_newsletter"
    t.integer  "review_report"
    t.integer  "compliance_rating"
    t.integer  "allow_prescriber_access"
    t.date     "last_contact"
    t.integer  "last_contact_type"
    t.integer  "last_contact_status"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "customer_wellnesses", ["customer_id"], name: "index_customer_wellnesses_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "person_image_id"
    t.integer  "prescriber_id"
    t.integer  "facility_id"
    t.integer  "head_of_household_id"
    t.integer  "legacy_customer_id_number"
    t.boolean  "active"
    t.string   "last_name",                    limit: 25
    t.string   "first_name",                   limit: 20
    t.string   "middle_name",                  limit: 20
    t.string   "address1",                     limit: 30
    t.string   "address2",                     limit: 30
    t.string   "city",                         limit: 30
    t.string   "state",                        limit: 2
    t.string   "zip_code",                     limit: 10
    t.boolean  "doc_u_dose"
    t.string   "doc_u_dose_group",             limit: 5
    t.date     "birthdate"
    t.integer  "ssn",                          limit: 8
    t.integer  "phone_number",                 limit: 8
    t.boolean  "alternate_address"
    t.integer  "gender"
    t.boolean  "tax_exempt"
    t.string   "discount_name",                limit: 15
    t.decimal  "discount_pct",                            precision: 2, scale: 2
    t.boolean  "nursing_home_resident"
    t.integer  "price_based_pricing_schedule"
    t.boolean  "childproof_cap"
    t.boolean  "generic_substitution"
    t.date     "last_rx_report_date"
    t.boolean  "pregnant"
    t.boolean  "nursing"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "other_language"
    t.boolean  "terminal"
    t.date     "deceased_date"
    t.boolean  "needs_review"
    t.boolean  "signature_on_file"
    t.date     "hippa_signature_date"
    t.boolean  "smoker"
    t.integer  "location_code"
    t.integer  "residence_code"
    t.boolean  "wellness"
    t.string   "ethnicity",                    limit: 20
    t.integer  "preferred_contact_method"
    t.integer  "account_number"
    t.string   "memo",                         limit: 30
    t.text     "notes"
    t.boolean  "special_label"
    t.boolean  "receive_text_msg"
    t.boolean  "auto_fill_maintenance_rx"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "customers", ["birthdate"], name: "index_customers_on_birthdate", using: :btree
  add_index "customers", ["facility_id"], name: "index_customers_on_facility_id", using: :btree
  add_index "customers", ["last_name", "first_name"], name: "index_customers_on_last_name_and_first_name", using: :btree
  add_index "customers", ["person_image_id"], name: "index_customers_on_person_image_id", using: :btree
  add_index "customers", ["phone_number"], name: "index_customers_on_phone_number", using: :btree
  add_index "customers", ["prescriber_id"], name: "index_customers_on_prescriber_id", using: :btree
  add_index "customers", ["ssn"], name: "index_customers_on_ssn", using: :btree

  create_table "dispense_compound_items", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "dispense_compound_id"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "legacy_item_id_number"
    t.string   "legend_drug"
    t.integer  "ndc_number",             limit: 8
    t.integer  "basis_of_cost"
    t.string   "alternate_product_type", limit: 1
    t.string   "alternate_product_code", limit: 13
    t.decimal  "quantity_dispensed",                precision: 9, scale: 3
    t.decimal  "base_cost",                         precision: 8, scale: 2
    t.decimal  "acquistion_cost",                   precision: 8, scale: 2
    t.string   "lot_number",                                                             array: true
    t.string   "serial_number",                                                          array: true
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "dispense_compound_items", ["dispense_compound_id"], name: "index_dispense_compound_items_on_dispense_compound_id", using: :btree

  create_table "dispense_compounds", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "dispense_id"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "number_rx_ingredients"
    t.integer  "number_non_rx_ingedients"
    t.decimal  "total_base_cost",                     precision: 8, scale: 2
    t.decimal  "total_acquisition_cost",              precision: 8, scale: 2
    t.integer  "dosage_form"
    t.integer  "dispensing_unit"
    t.string   "route",                    limit: 11
    t.integer  "therapy_type"
    t.integer  "level_of_effort"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "dispense_compounds", ["dispense_id"], name: "index_dispense_compounds_on_dispense_id", using: :btree

  create_table "dispenses", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "prescription_id"
    t.integer  "item_id"
    t.integer  "rx_signature_id"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "legacy_customer_id_number"
    t.datetime "fill_time"
    t.integer  "legacy_item_id_number"
    t.integer  "refill_type"
    t.integer  "status"
    t.boolean  "split_bill_rx"
    t.boolean  "billing_complete"
    t.string   "pharmacist_initials",       limit: 4
    t.string   "technician_initials",       limit: 4
    t.decimal  "quantity",                            precision: 9, scale: 3
    t.integer  "days_supply"
    t.string   "delivery_route",            limit: 2
    t.string   "lot_number",                                                               array: true
    t.string   "serial_number",                                                            array: true
    t.date     "discard_date"
    t.decimal  "price",                               precision: 8, scale: 2
    t.decimal  "usual_customary_price",               precision: 8, scale: 2
    t.decimal  "base_cost",                           precision: 8, scale: 2
    t.decimal  "acquisition_cost",                    precision: 8, scale: 2
    t.decimal  "fee",                                 precision: 6, scale: 2
    t.decimal  "discount",                            precision: 6, scale: 2
    t.decimal  "tax",                                 precision: 6, scale: 2
    t.decimal  "ancillary_fee",                       precision: 6, scale: 2
    t.decimal  "professional_service_fee",            precision: 6, scale: 2
    t.integer  "cost_basis"
    t.integer  "other_coverage_code"
    t.decimal  "other_amount",                        precision: 6, scale: 2
    t.string   "other_amount_type",         limit: 2
    t.integer  "reason_for_delay"
    t.integer  "denial_override_code"
    t.integer  "partial_fill_status"
    t.integer  "reported_to_pmp"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "dispenses", ["customer_id"], name: "index_dispenses_on_customer_id", using: :btree
  add_index "dispenses", ["item_id"], name: "index_dispenses_on_item_id", using: :btree
  add_index "dispenses", ["prescription_id"], name: "index_dispenses_on_prescription_id", using: :btree
  add_index "dispenses", ["rx_number"], name: "index_dispenses_on_rx_number", using: :btree
  add_index "dispenses", ["rx_signature_id"], name: "index_dispenses_on_rx_signature_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "person_image_id"
    t.integer  "employee_id_number"
    t.boolean  "active"
    t.string   "last_name",              limit: 25
    t.string   "first_name",             limit: 20
    t.string   "middle_name",            limit: 20
    t.string   "initials",               limit: 4
    t.string   "address1",               limit: 30
    t.string   "address2",               limit: 30
    t.string   "city",                   limit: 30
    t.string   "state",                  limit: 2
    t.string   "zip_code",               limit: 10
    t.integer  "social_security_number"
    t.string   "password"
    t.date     "date_hired"
    t.date     "date_left"
    t.string   "employee_title",         limit: 20
    t.string   "credentials",            limit: 10
    t.integer  "npi_number"
    t.string   "license_number",         limit: 15
    t.string   "alternate_id_number",    limit: 15
    t.integer  "phone",                  limit: 8
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "employees", ["person_image_id"], name: "index_employees_on_person_image_id", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "facility_option_id"
    t.integer  "pass_time_id"
    t.integer  "legacy_id_number"
    t.string   "name",                     limit: 30
    t.string   "short_name",               limit: 10
    t.boolean  "active"
    t.string   "address1",                 limit: 30
    t.string   "address2",                 limit: 30
    t.string   "city",                     limit: 30
    t.string   "state",                    limit: 2
    t.string   "zip_code",                 limit: 10
    t.integer  "phone",                    limit: 8
    t.integer  "fax",                      limit: 8
    t.string   "email"
    t.integer  "account_number"
    t.string   "internal_id_number",       limit: 10
    t.string   "state_id_number",          limit: 12
    t.string   "medicare_id_number",       limit: 15
    t.integer  "npi_number"
    t.string   "administrator",            limit: 30
    t.string   "director_of_nursing",      limit: 30
    t.string   "other_contact",            limit: 30
    t.integer  "print_patient_counseling"
    t.integer  "select_counseling"
    t.integer  "check_dur"
    t.text     "standing_orders"
    t.integer  "type_of_facility"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "facility_options", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "price_based_pricing_schedule",                                                         array: true
    t.decimal  "universal_fee",                                   precision: 4, scale: 2
    t.decimal  "unit_dose_fee",                                   precision: 4, scale: 2
    t.decimal  "control_drug_fee",                                precision: 4, scale: 2
    t.decimal  "narcotic_fee",                                    precision: 4, scale: 2
    t.boolean  "allow_customer_discount"
    t.string   "label_type",                           limit: 2
    t.boolean  "spool_labels"
    t.integer  "label_default"
    t.boolean  "expiration_date"
    t.integer  "expiration_default"
    t.boolean  "lot_number"
    t.boolean  "doc_u_dose"
    t.boolean  "default_to_primary_plan"
    t.boolean  "valid_division_codes"
    t.boolean  "form_flags"
    t.boolean  "start_date"
    t.boolean  "post_zero_copay"
    t.boolean  "frequency_auto_fill"
    t.boolean  "anniversary_auto_fill"
    t.boolean  "procycle_auto_fill"
    t.integer  "print_monograph"
    t.boolean  "log_dur_results"
    t.integer  "require_hippa_privacy_notice"
    t.integer  "print_medication_guide"
    t.boolean  "print_medication_administration_form"
    t.boolean  "print_physician_order_form"
    t.boolean  "print_treatment_form"
    t.boolean  "print_delivery_receipt"
    t.string   "medication_administration_form",       limit: 12
    t.string   "physician_orders_form",                limit: 12
    t.string   "treatment_form",                       limit: 12
    t.integer  "print_order"
    t.boolean  "print_pass_times"
    t.boolean  "print_other_allergy"
    t.string   "med_administration_routine_heading",   limit: 12
    t.string   "med_administration_prn_heading",       limit: 12
    t.string   "treatment_heading",                    limit: 12
    t.boolean  "print_fill_date"
    t.boolean  "print_original_date"
    t.boolean  "print_in_frequency_order"
    t.boolean  "require_rx_copy_in_facility"
    t.boolean  "expand_sig_codes"
    t.text     "standing_orders"
    t.integer  "type_of_facility"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  create_table "facility_orders", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "facility_id"
    t.integer  "wing_id"
    t.boolean  "active_flag"
    t.string   "code",              limit: 8
    t.text     "order_description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "formulas", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "item_id"
    t.integer  "legacy_item_id_number"
    t.integer  "compound_form"
    t.integer  "dispensing_unit"
    t.integer  "route_of_administration"
    t.decimal  "total_acquisition_cost",    precision: 9,  scale: 2
    t.decimal  "total_base_cost",           precision: 9,  scale: 2
    t.decimal  "quantity_produced",         precision: 10, scale: 3
    t.integer  "number_legend_ingredients"
    t.integer  "number_otc_ingredients"
    t.integer  "level_of_effort_code"
    t.text     "instructions"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "formulas", ["item_id"], name: "index_formulas_on_item_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "formula_id"
    t.integer  "item_id"
    t.integer  "legacy_item_id_number"
    t.integer  "ndc_number",             limit: 8
    t.integer  "basis_of_cost"
    t.decimal  "base_cost",                         precision: 9,  scale: 2
    t.decimal  "acquisition_cost",                  precision: 9,  scale: 2
    t.decimal  "quantity",                          precision: 10, scale: 3
    t.string   "alternate_product_type", limit: 1
    t.string   "alternate_product_code", limit: 13
    t.decimal  "waste_factor",                      precision: 3,  scale: 2
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "ingredients", ["formula_id"], name: "index_ingredients_on_formula_id", using: :btree
  add_index "ingredients", ["item_id"], name: "index_ingredients_on_item_id", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "item_id"
    t.date     "last_order_date"
    t.decimal  "last_package_cost",               precision: 9,  scale: 2
    t.decimal  "reorder_point",                   precision: 10, scale: 3
    t.decimal  "quantity_on_order",               precision: 10, scale: 3
    t.decimal  "optimal_quantity",                precision: 10, scale: 3
    t.integer  "supplier_id",                                                           array: true
    t.string   "supplier_order_number",                                                 array: true
    t.decimal  "supplier_minimum_order_quantity",                                       array: true
    t.decimal  "supplier_cost",                                                         array: true
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "inventories", ["item_id"], name: "index_inventories_on_item_id", using: :btree

  create_table "item_pedigrees", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "item_id"
    t.integer  "supplier_id"
    t.boolean  "active"
    t.string   "lot_number",         limit: 15
    t.string   "serial_number",      limit: 15
    t.date     "date_received"
    t.decimal  "quantity_received",             precision: 10, scale: 3
    t.decimal  "quantity_remaining",            precision: 10, scale: 3
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "item_pedigrees", ["item_id"], name: "index_item_pedigrees_on_item_id", using: :btree
  add_index "item_pedigrees", ["supplier_id"], name: "index_item_pedigrees_on_supplier_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "cdb_monograph_id"
    t.integer  "price_based_pricing_schedule"
    t.integer  "quantity_based_pricing_schedule"
    t.integer  "legacy_item_id_number"
    t.string   "item_name",                       limit: 30
    t.string   "mfg_description"
    t.integer  "ndc_number",                      limit: 8
    t.integer  "scanned_ndc_number",              limit: 8
    t.integer  "clinical_ndc_number",             limit: 8
    t.string   "synonym",                         limit: 6
    t.integer  "ddid_number"
    t.integer  "kdc_code",                        limit: 8
    t.string   "generic_product_identifier",      limit: 14
    t.boolean  "active"
    t.integer  "dea_schedule"
    t.decimal  "awp_unit_price",                             precision: 11, scale: 4
    t.decimal  "mac_unit_price",                             precision: 11, scale: 4
    t.decimal  "act_unit_price",                             precision: 11, scale: 4
    t.decimal  "wac_unit_price",                             precision: 11, scale: 4
    t.decimal  "govt_340b_unit_price",                       precision: 11, scale: 4
    t.decimal  "contract_unit_price",                        precision: 11, scale: 4
    t.decimal  "nadac_unit_price",                           precision: 11, scale: 4
    t.decimal  "custom_unit_price",                          precision: 11, scale: 4
    t.boolean  "awp_automatic_update"
    t.boolean  "mac_automatic_update"
    t.boolean  "act_automatic_update"
    t.boolean  "wac_automatic_update"
    t.boolean  "govt_340b_automatic_update"
    t.boolean  "contract_automatic_update"
    t.boolean  "nadac_automatic_update"
    t.boolean  "custom_automatic_update"
    t.date     "last_awp_update_date"
    t.date     "last_mac_update_date"
    t.date     "last_act_update_date"
    t.date     "last_wac_update_date"
    t.date     "last_340b_update_date"
    t.date     "last_contract_update_date"
    t.date     "last_nadac_update_date"
    t.date     "last_custom_update_date"
    t.string   "route_of_administration_code",    limit: 2
    t.string   "dosage_form",                     limit: 4
    t.boolean  "inventory"
    t.decimal  "quantity_on_hand",                           precision: 11, scale: 4
    t.string   "strength",                        limit: 15
    t.decimal  "package_size",                               precision: 11, scale: 4
    t.string   "package_size_unit_measure",       limit: 2
    t.string   "mfg_name"
    t.integer  "drug_class"
    t.boolean  "item_taxable"
    t.string   "dispensing_unit",                 limit: 5
    t.string   "state_billing_code",              limit: 11
    t.string   "alternate_product_code",          limit: 11
    t.string   "alternate_product_qualifier",     limit: 2
    t.string   "memo",                            limit: 30
    t.text     "notes"
    t.text     "counseling_notes"
    t.integer  "brand_generic_compound"
    t.integer  "brand_generic_xref"
    t.decimal  "fed_tax",                                    precision: 11, scale: 4
    t.string   "unit_of_measure",                 limit: 3
    t.string   "dosage_form_code",                limit: 7
    t.string   "strength_unit_measure_code",      limit: 10
    t.string   "potency_code",                    limit: 8
    t.integer  "maintenance_code"
    t.boolean  "doc_u_dose"
    t.integer  "discard_age_days"
    t.boolean  "remote_dispensing"
    t.string   "image_file_name",                 limit: 20
    t.string   "imprint_side1",                   limit: 40
    t.string   "imprint_side2",                   limit: 40
    t.string   "clarity",                         limit: 30
    t.string   "coating",                         limit: 30
    t.string   "color",                           limit: 30
    t.string   "flavor",                          limit: 30
    t.string   "scored",                          limit: 30
    t.string   "shape",                           limit: 25
    t.text     "appearance_text"
    t.string   "monitoring_program",              limit: 1
    t.string   "monitoring_file_name",            limit: 13
    t.string   "monograph_file_name",             limit: 30
    t.string   "medication_guide_file_name",      limit: 30
    t.string   "black_box_file_name",             limit: 30
    t.boolean  "contains_acetaminophen"
    t.boolean  "contains_pseudoephedrine"
    t.string   "label_warnings",                                                                   array: true
    t.boolean  "active_ingredient"
    t.boolean  "wellness_tracking"
    t.date     "retest_date"
    t.boolean  "limited_distribution"
    t.boolean  "on_contract"
    t.boolean  "gpo_drug"
    t.boolean  "pos_item"
    t.string   "upc_product_number",              limit: 18
    t.string   "upc_category",                    limit: 3
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "brand_item_id"
  end

  add_index "items", ["cdb_monograph_id"], name: "index_items_on_cdb_monograph_id", using: :btree
  add_index "items", ["generic_product_identifier"], name: "index_items_on_generic_product_identifier", using: :btree
  add_index "items", ["item_name"], name: "index_items_on_item_name", using: :btree
  add_index "items", ["ndc_number"], name: "index_items_on_ndc_number", using: :btree
  add_index "items", ["scanned_ndc_number"], name: "index_items_on_scanned_ndc_number", using: :btree
  add_index "items", ["synonym"], name: "index_items_on_synonym", using: :btree

  create_table "organization_images", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "supplier_id"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "person_images", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "prescriber_id"
    t.integer  "plan_id"
    t.integer  "residency_id"
    t.integer  "supplier_id"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "pharmacies", force: :cascade do |t|
    t.integer  "company_id"
    t.boolean  "active"
    t.string   "pharmacy_name",         limit: 30
    t.string   "address1",              limit: 30
    t.string   "address2",              limit: 30
    t.string   "city",                  limit: 30
    t.string   "state",                 limit: 2
    t.string   "zip_code",              limit: 10
    t.integer  "rna_account_number"
    t.date     "expiration_date"
    t.integer  "ncpdp_number"
    t.string   "dea_number",            limit: 10
    t.integer  "npi_number",            limit: 8
    t.integer  "max_sessions"
    t.string   "federal_tax_id_number", limit: 10
    t.boolean  "rx_taxable_flag"
    t.decimal  "local_tax_rate",                    precision: 4, scale: 4
    t.decimal  "state_tax_rate",                    precision: 4, scale: 4
    t.decimal  "total_tax_rate",                    precision: 4, scale: 4
    t.integer  "pharmacy_type"
    t.integer  "claimguard_counter"
    t.integer  "eligibility_counter"
    t.integer  "us_or_metric"
    t.string   "promotional_message",   limit: 160
    t.integer  "fax_number",            limit: 8
    t.integer  "phone_number",          limit: 8
    t.string   "email"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "plan_requirements", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "plan_id"
    t.integer  "plan_id_code"
    t.string   "version_number",                       limit: 2
    t.string   "software_id",                          limit: 10
    t.integer  "provider_id_qualifier"
    t.string   "provider_id_number",                   limit: 15
    t.boolean  "otc_ingredients_on_compound"
    t.boolean  "bundle_claims"
    t.boolean  "copay_assist_plan"
    t.boolean  "facility_segment"
    t.boolean  "prescriber_segment"
    t.boolean  "prior_authorization_segment"
    t.boolean  "coordination_of_benefits_segment"
    t.boolean  "compound_segment"
    t.boolean  "drug_utilization_review_segment"
    t.boolean  "clinical_segment"
    t.boolean  "coupon_segment"
    t.boolean  "workers_compensation_segment"
    t.integer  "patient_birthdate"
    t.integer  "patient_gender"
    t.integer  "patient_first_name"
    t.integer  "patient_last_name"
    t.integer  "patient_address"
    t.integer  "patient_city"
    t.integer  "patient_state"
    t.integer  "patient_zip_code"
    t.integer  "patient_phone"
    t.integer  "patient_residence_code"
    t.integer  "patient_location_code"
    t.integer  "patient_smoker"
    t.integer  "patient_pregnant"
    t.integer  "patient_email"
    t.integer  "patient_employer_id"
    t.integer  "patient_universal_id"
    t.integer  "cardholder_id_number"
    t.integer  "group_id_number"
    t.integer  "plan_id_number"
    t.integer  "person_code"
    t.integer  "cardholder_first_name"
    t.integer  "cardholder_last_name"
    t.integer  "relationship_code"
    t.integer  "home_plan"
    t.integer  "eligibility_code"
    t.integer  "facility_id_number"
    t.integer  "medigap_indicator"
    t.integer  "assignment_indicator"
    t.integer  "partd_indicator"
    t.integer  "medicaid_indicator"
    t.integer  "medicaid_id_number"
    t.integer  "fill_number"
    t.integer  "days_supply"
    t.integer  "dispense_as_written_code"
    t.integer  "quantity_dispensed"
    t.integer  "date_written"
    t.integer  "refills_prescribed"
    t.integer  "origin_code"
    t.integer  "compound_indicator"
    t.integer  "compound_type"
    t.integer  "product_id_number_qualifier"
    t.integer  "product_id_number"
    t.integer  "route_of_administration"
    t.integer  "pharmacy_type"
    t.integer  "denial_override_code"
    t.integer  "denial_override_count"
    t.integer  "quantity_prescribed"
    t.integer  "other_coverage"
    t.integer  "regular_prior_authorization"
    t.integer  "regular_prior_authorization_type"
    t.integer  "dispense_status"
    t.integer  "intended_quantity"
    t.integer  "intended_days_supply"
    t.integer  "level_of_service"
    t.integer  "unit_of_measure"
    t.integer  "unit_dose_indicator"
    t.integer  "delay_code"
    t.integer  "dea_blank_number"
    t.integer  "patient_rx_assignment"
    t.integer  "alternate_id_number"
    t.integer  "original_product_id_number"
    t.integer  "original_quantity_prescribed"
    t.integer  "associated_rx_number"
    t.integer  "associated_date"
    t.integer  "procedure_modifier"
    t.integer  "intermediary_type"
    t.integer  "intermediary_authorization"
    t.integer  "prescriber_id_number_qualifier"
    t.integer  "prescriber_first_name"
    t.integer  "prescriber_last_name"
    t.integer  "prescriber_address"
    t.integer  "prescriber_city"
    t.integer  "prescriber_state"
    t.integer  "prescriber_zip_code"
    t.integer  "prescriber_phone_number"
    t.integer  "prescriber_location"
    t.integer  "primary_prescriber_id_qualifier"
    t.integer  "primary_prescriber_last_name"
    t.integer  "primary_prescriber_location"
    t.integer  "other_payor_count"
    t.integer  "other_payor_coverage_type"
    t.integer  "other_payor_id_number"
    t.integer  "other_payor_date"
    t.integer  "other_payor_amount_paid"
    t.integer  "other_payor_reject_count"
    t.integer  "other_payor_reject_code"
    t.integer  "other_payor_patient_amount_count"
    t.integer  "other_payor_patient_amount_qualifier"
    t.integer  "other_payor_patient_amount"
    t.integer  "other_payor_benefit_count"
    t.integer  "other_payor_benefit_qualifier"
    t.integer  "other_payor_benefit_amount"
    t.integer  "other_payor_control_number"
    t.integer  "dur_counter"
    t.integer  "dur_reason_code"
    t.integer  "dur_service_code"
    t.integer  "dur_result_code"
    t.integer  "dur_effort_code"
    t.integer  "dur_coagent"
    t.integer  "base_cost"
    t.integer  "dispensing_fee"
    t.integer  "service_fee"
    t.integer  "copay"
    t.integer  "incentive_fee"
    t.integer  "other_amount"
    t.integer  "flat_tax_amount"
    t.integer  "pct_tax_amount"
    t.integer  "tax_rate"
    t.integer  "tax_basis"
    t.integer  "usual_customary_price"
    t.integer  "amount_due"
    t.integer  "basis_of_cost"
    t.integer  "price_override"
    t.integer  "dosage_form"
    t.integer  "dispensing_unit"
    t.integer  "ingredient_id_number"
    t.integer  "ingredient_quantity_dispensed"
    t.integer  "ingredient_cost"
    t.integer  "ingredient_cost_basis"
    t.integer  "ingredient_modifier_count"
    t.integer  "ingredient_modifier"
    t.integer  "date_of_injury"
    t.integer  "employer_name"
    t.integer  "employer_address"
    t.integer  "employer_city"
    t.integer  "employer_state"
    t.integer  "employer_zip_code"
    t.integer  "employer_phone"
    t.integer  "employer_contact"
    t.integer  "carrier_id_number"
    t.integer  "employer_reference_id"
    t.integer  "employer_type"
    t.integer  "pay_to_qualifier"
    t.integer  "pay_to_id_number"
    t.integer  "pay_to_name"
    t.integer  "pay_to_address"
    t.integer  "pay_to_city"
    t.integer  "pay_to_state"
    t.integer  "pay_to_zip_code"
    t.integer  "general_id_qualifier"
    t.integer  "general_id_number"
    t.integer  "request_type"
    t.integer  "request_begin_date"
    t.integer  "request_end_date"
    t.integer  "request_basis"
    t.integer  "representative_first_name"
    t.integer  "representative_last_name"
    t.integer  "representative_address"
    t.integer  "representative_city"
    t.integer  "representative_state"
    t.integer  "representative_zip_code"
    t.integer  "prior_authorization_assigned"
    t.integer  "prior_authorization_number"
    t.integer  "prior_authorization_prescriber"
    t.integer  "diagnosis_count"
    t.integer  "diagnosis_code"
    t.integer  "clinical_count"
    t.integer  "clinical_date"
    t.integer  "clinical_time"
    t.integer  "clinical_dimension"
    t.integer  "clinical_unit"
    t.integer  "clinical_value"
    t.integer  "coupon_type"
    t.integer  "coupon_number"
    t.integer  "coupon_amount"
    t.integer  "secondary_provider_id_qualifier"
    t.integer  "secondary_provider_id_number"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "plan_requirements", ["plan_id"], name: "index_plan_requirements_on_plan_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "plan_id_code"
    t.integer  "bin_number"
    t.string   "processor_control_number",     limit: 10
    t.string   "insurance_plan_name",          limit: 30
    t.string   "abbreviated_name",             limit: 6
    t.boolean  "active"
    t.integer  "plan_type"
    t.integer  "payor_type"
    t.integer  "print_sort_code"
    t.string   "provider_number",              limit: 15
    t.integer  "account_number"
    t.string   "address1",                     limit: 30
    t.string   "address2",                     limit: 30
    t.string   "city",                         limit: 30
    t.string   "state",                        limit: 2
    t.string   "zip_code",                     limit: 10
    t.integer  "phone",                        limit: 8
    t.integer  "fax",                          limit: 8
    t.string   "email"
    t.decimal  "extra_unit_dose_fee",                     precision: 5, scale: 2
    t.decimal  "extra_ctrl_fee",                          precision: 5, scale: 2
    t.decimal  "extra_narcotic_fee",                      precision: 5, scale: 2
    t.decimal  "extra_delivery_fee",                      precision: 5, scale: 2
    t.decimal  "extra_ancillary_fee",                     precision: 5, scale: 2
    t.boolean  "patient_price_schedule_apply"
    t.integer  "copay_type"
    t.boolean  "adjudicate_claims"
    t.boolean  "do_discounts_apply"
    t.integer  "support_split_billing"
    t.string   "split_bill_format",            limit: 1
    t.boolean  "authorization_on_label"
    t.boolean  "plan_info_on_label"
    t.boolean  "submit_as_cash"
    t.integer  "price_based_pricing_schedule",                                                 array: true
    t.text     "notes"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "pos_categories", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "pos_tax_id"
    t.string   "category_abbreviation", limit: 3
    t.string   "category_description",  limit: 20
    t.boolean  "taxable"
    t.boolean  "medical"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "pos_categories", ["pos_tax_id"], name: "index_pos_categories_on_pos_tax_id", using: :btree

  create_table "pos_details", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "pos_transaction_id"
    t.integer  "ticket_number"
    t.integer  "sequence_number"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.string   "category",           limit: 3
    t.integer  "quantity"
    t.string   "item_type",          limit: 3
    t.string   "item_number",        limit: 18
    t.string   "item_description",   limit: 20
    t.decimal  "price",                         precision: 7, scale: 2
    t.decimal  "extended_price",                precision: 7, scale: 2
    t.decimal  "tax_amount",                    precision: 5, scale: 2
    t.boolean  "medical_item"
    t.boolean  "price_override"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "pos_details", ["pos_transaction_id"], name: "index_pos_details_on_pos_transaction_id", using: :btree

  create_table "pos_payment_methods", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "payment_method_code",               limit: 3
    t.string   "payment_method_description",        limit: 20
    t.decimal  "payment_method_processing_percent",            precision: 4, scale: 4
    t.string   "merchant_id_number",                limit: 12
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "pos_taxes", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "tax_code",        limit: 3
    t.string   "tax_description", limit: 20
    t.decimal  "tax_rate",                   precision: 4, scale: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "pos_transactions", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.date     "transaction_date"
    t.integer  "ticket_number"
    t.integer  "legacy_customer_id_number"
    t.string   "initials",                  limit: 3
    t.integer  "register_number"
    t.integer  "account_number"
    t.boolean  "posted_flag"
    t.boolean  "any_flex_spending_items"
    t.integer  "number_items"
    t.string   "primary_payment_method",    limit: 3
    t.decimal  "primary_payment_amount",              precision: 7, scale: 2
    t.string   "secondary_payment_method",  limit: 3
    t.decimal  "secondary_payment_amount",            precision: 7, scale: 2
    t.decimal  "total_amount",                        precision: 8, scale: 2
    t.decimal  "total_tax",                           precision: 7, scale: 2
    t.decimal  "medical_amount",                      precision: 8, scale: 2
    t.decimal  "medical_tax",                         precision: 7, scale: 2
    t.decimal  "medical_total",                       precision: 8, scale: 2
    t.decimal  "non_medical_amount",                  precision: 8, scale: 2
    t.decimal  "non_medical_tax",                     precision: 7, scale: 2
    t.decimal  "non_medical_total",                   precision: 8, scale: 2
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  create_table "prescribers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "person_image_id"
    t.integer  "legacy_prescriber_id_number"
    t.string   "last_name",                       limit: 25
    t.string   "first_name",                      limit: 20
    t.string   "middle_name",                     limit: 20
    t.string   "dea_number",                      limit: 10
    t.integer  "npi_number",                      limit: 8
    t.integer  "surescripts_erx_id_number",       limit: 8
    t.string   "emdeon_erx_id_number",            limit: 15
    t.boolean  "active"
    t.boolean  "participates_in_340b"
    t.string   "location_code",                   limit: 3
    t.boolean  "requires_supervisor"
    t.string   "address1",                        limit: 30
    t.string   "address2",                        limit: 30
    t.string   "city",                            limit: 30
    t.string   "state",                           limit: 2
    t.string   "zip_code",                        limit: 10
    t.string   "specialty",                       limit: 30
    t.text     "notes"
    t.string   "memo",                            limit: 30
    t.string   "group_code",                      limit: 6
    t.boolean  "sig_default"
    t.boolean  "erx_eligibility"
    t.boolean  "remote_access"
    t.integer  "facility_number"
    t.boolean  "allowed_to_prescribe_narcotics"
    t.boolean  "allowed_to_prescribe_controlled"
    t.integer  "alternate_id1_qualifier"
    t.string   "alternate_id1",                   limit: 15
    t.integer  "alternate_id1_source"
    t.integer  "alternate_id2_qualifier"
    t.string   "alternate_id2",                   limit: 15
    t.integer  "alternate_id2_source"
    t.integer  "alternate_id3_qualifier"
    t.string   "alternate_id3",                   limit: 15
    t.integer  "alternate_id3_source"
    t.integer  "alternate_id4_qualifier"
    t.string   "alternate_id4",                   limit: 15
    t.integer  "alternate_id4_source"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "prescribers", ["person_image_id"], name: "index_prescribers_on_person_image_id", using: :btree

  create_table "prescriptions", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "prescriber_id"
    t.integer  "item_id"
    t.integer  "rx_image_id"
    t.integer  "supervising_prescriber_id"
    t.integer  "rx_number"
    t.integer  "legacy_customer_id_number"
    t.integer  "legacy_prescriber_id_number"
    t.integer  "legacy_item_id_number"
    t.integer  "original_refills_prescribed"
    t.integer  "refills_prescribed"
    t.integer  "refills_left"
    t.decimal  "original_total_quantity_prescribed",            precision: 9, scale: 3
    t.decimal  "quantity_remaining",                            precision: 9, scale: 3
    t.decimal  "quantity_prescribed",                           precision: 9, scale: 3
    t.decimal  "daily_quantity",                                precision: 7, scale: 3
    t.boolean  "active"
    t.integer  "rx_type"
    t.integer  "status"
    t.integer  "dea_schedule"
    t.integer  "dispense_as_written_code"
    t.integer  "certification_code"
    t.string   "diagnosis_code",                     limit: 10
    t.integer  "diagnosis_code_qualifier"
    t.integer  "prior_authorization_number",         limit: 8
    t.integer  "prior_authorization_type"
    t.integer  "origin_code"
    t.date     "refill_through_date"
    t.date     "expiration_date"
    t.date     "date_written"
    t.integer  "renewed_rx_number"
    t.date     "renewed_rx_date"
    t.string   "retail_auto_fill_type",              limit: 1
    t.date     "retail_auto_fill_next_date"
    t.date     "last_fill_date"
    t.integer  "last_fill_number"
    t.decimal  "last_fill_quantity",                            precision: 9, scale: 3
    t.integer  "last_fill_days_supply"
    t.integer  "last_fill_primary_paytype"
    t.decimal  "last_fill_price",                               precision: 8, scale: 2
    t.decimal  "last_fill_discount",                            precision: 8, scale: 2
    t.integer  "last_fill_legacy_item_id_number"
    t.boolean  "doc_u_dose_rx"
    t.boolean  "on_docudose_calendar"
    t.text     "directions"
    t.integer  "sig_frequency"
    t.text     "notes"
    t.text     "counseling"
    t.string   "print_division_code",                limit: 3
    t.boolean  "print_on_prn"
    t.boolean  "print_on_mar"
    t.boolean  "print_on_po"
    t.boolean  "print_on_treatment"
    t.boolean  "print_on_flow"
    t.string   "pass_times",                                                                         array: true
    t.integer  "auto_fill_type"
    t.date     "auto_fill_next_date"
    t.decimal  "procycle_quantity_dispensed",                   precision: 9, scale: 3
    t.decimal  "procycle_quantity_left",                        precision: 9, scale: 3
    t.date     "start_date"
    t.date     "stop_date"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "prescriptions", ["customer_id"], name: "index_prescriptions_on_customer_id", using: :btree
  add_index "prescriptions", ["item_id"], name: "index_prescriptions_on_item_id", using: :btree
  add_index "prescriptions", ["prescriber_id"], name: "index_prescriptions_on_prescriber_id", using: :btree
  add_index "prescriptions", ["rx_image_id"], name: "index_prescriptions_on_rx_image_id", using: :btree
  add_index "prescriptions", ["rx_number"], name: "index_prescriptions_on_rx_number", using: :btree

  create_table "price_breaks", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "price_schedule_id"
    t.integer  "number"
    t.integer  "percent_or_amount"
    t.decimal  "break_limit",       precision: 7, scale: 3
    t.integer  "markup_percent"
    t.decimal  "markup_amount",     precision: 5, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "price_breaks", ["price_schedule_id"], name: "index_price_breaks_on_price_schedule_id", using: :btree

  create_table "price_histories", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "item_id"
    t.integer  "employee_id"
    t.string   "mode",            limit: 1
    t.integer  "mechanism"
    t.integer  "source"
    t.integer  "element_changed"
    t.decimal  "old_price",                 precision: 9, scale: 4
    t.decimal  "new_price",                 precision: 9, scale: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "price_histories", ["employee_id"], name: "index_price_histories_on_employee_id", using: :btree
  add_index "price_histories", ["item_id"], name: "index_price_histories_on_item_id", using: :btree

  create_table "price_schedules", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "number"
    t.boolean  "active"
    t.integer  "basis"
    t.string   "name",                           limit: 15
    t.integer  "break_type"
    t.integer  "qualifier"
    t.integer  "fee_calculation_type"
    t.integer  "usual_customary_calculation"
    t.integer  "customer_assigned_schedule"
    t.boolean  "generic_percentage_calculation"
    t.boolean  "discounts_allowed"
    t.boolean  "cumulative"
    t.boolean  "exact_hit"
    t.boolean  "round_price"
    t.decimal  "round_to_amount",                           precision: 3, scale: 2
    t.integer  "percentage_fee_type"
    t.integer  "amount_fee_type"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  create_table "residencies", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "customer_id"
    t.integer  "facility_id"
    t.integer  "legacy_customer_id_number"
    t.date     "admission_date"
    t.date     "discharge_date"
    t.string   "medical_record_number",     limit: 12
    t.string   "level_of_care",             limit: 1
    t.string   "rehabilitation_potential",  limit: 1
    t.date     "last_review_date"
    t.text     "diet_orders"
    t.text     "lab_orders"
    t.text     "activity_orders"
    t.text     "diagnosis"
    t.text     "other_allergies"
    t.text     "non_med_orders"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "residencies", ["customer_id"], name: "index_residencies_on_customer_id", using: :btree
  add_index "residencies", ["facility_id"], name: "index_residencies_on_facility_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rx_images", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "rx_payments", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "dispense_id"
    t.integer  "rx_number"
    t.integer  "fill_number"
    t.integer  "payor_sequence"
    t.integer  "plan_id_code"
    t.decimal  "amount_paid",    precision: 8, scale: 2
    t.integer  "posted"
    t.boolean  "billed"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "rx_payments", ["dispense_id"], name: "index_rx_payments_on_dispense_id", using: :btree
  add_index "rx_payments", ["rx_number", "fill_number"], name: "index_rx_payments_on_rx_number_and_fill_number", using: :btree

  create_table "rx_signatures", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "rxoptions", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "days_until_expiration"
    t.integer  "cost_report_option"
    t.integer  "last_new_rx_number"
    t.boolean  "use_split_billing"
    t.boolean  "process_internet_claims"
    t.boolean  "data_collection"
    t.integer  "switch_type"
    t.integer  "erx_interface"
    t.boolean  "print_erx_hard_copy"
    t.boolean  "erx_refill_request"
    t.boolean  "submit_cash_rx"
    t.integer  "submit_cash_paytype"
    t.boolean  "refill_through_date"
    t.boolean  "enter_daily_quantity"
    t.boolean  "enter_expiration_date"
    t.boolean  "enter_lot_number"
    t.boolean  "enter_serialization_info"
    t.boolean  "enter_discard_date"
    t.boolean  "enter_delivery_route"
    t.boolean  "enter_route_of_administration"
    t.boolean  "manual_counseling"
    t.boolean  "additional_dea_documentation"
    t.boolean  "realtime_drug_reporting"
    t.boolean  "privacy_warning"
    t.boolean  "workflow"
    t.boolean  "display_rx_profile"
    t.boolean  "display_customer_note"
    t.boolean  "display_prescriber_note"
    t.boolean  "display_item_note"
    t.boolean  "display_rx_note"
    t.integer  "default_paytype_option"
    t.boolean  "allow_rx_charge_account"
    t.string   "label_type",                    limit: 2
    t.boolean  "print_discount_on_label"
    t.boolean  "print_barcode_on_label"
    t.boolean  "print_barcode_on_receipt"
    t.boolean  "print_store_heading"
    t.boolean  "print_warning_labels"
    t.boolean  "require_date_written_entry"
    t.boolean  "fax_interface"
    t.boolean  "text_message"
    t.boolean  "email_messages"
    t.boolean  "web_portal"
    t.boolean  "doc_u_dose"
    t.boolean  "nursing_home"
    t.string   "ivr_interface",                 limit: 10
    t.string   "robotic_interface",             limit: 10
    t.boolean  "remote_prescriber_interface"
    t.boolean  "remote_customer_interface"
    t.boolean  "customer_wellness"
    t.boolean  "netrx_interface"
    t.boolean  "prescribe_wellness_interface"
    t.boolean  "cover_my_meds_interface"
    t.boolean  "script_ability_interface"
    t.integer  "system_type"
    t.integer  "system_network_type"
    t.boolean  "med_tablet"
    t.boolean  "drug_pedigree"
    t.boolean  "imedicare"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "sigcodes", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.string   "sig_code",      limit: 8
    t.boolean  "active"
    t.integer  "language"
    t.text     "expanded_text"
    t.integer  "frequency"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "supervising_prescribers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.boolean  "active"
    t.integer  "supervisor_id_number"
    t.integer  "supervisee_id_number"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "organization_image_id"
    t.boolean  "active"
    t.string   "name",                    limit: 30
    t.string   "address1",                limit: 30
    t.string   "address2",                limit: 30
    t.string   "city",                    limit: 30
    t.string   "state",                   limit: 2
    t.string   "zip_code",                limit: 10
    t.integer  "phone",                   limit: 8
    t.integer  "fax",                     limit: 8
    t.string   "email"
    t.string   "vendor_pharmacy_account", limit: 15
    t.string   "login_user_name",         limit: 15
    t.string   "login_password"
    t.string   "website",                 limit: 60
    t.boolean  "allow_controlled_items"
    t.boolean  "allow_narcotic_items"
    t.integer  "order_by_number"
    t.boolean  "retain_backorders"
    t.boolean  "x12_supported"
    t.integer  "purchase_order_type"
    t.integer  "purchase_order_format"
    t.date     "last_order_date"
    t.decimal  "credit_limit",                       precision: 9, scale: 2
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "suppliers", ["organization_image_id"], name: "index_suppliers_on_organization_image_id", using: :btree

  create_table "transfer_pharmacies", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.boolean  "active"
    t.string   "name",        limit: 30
    t.string   "address1",    limit: 30
    t.string   "address2",    limit: 30
    t.string   "city",        limit: 30
    t.string   "state",       limit: 2
    t.string   "zip_code",    limit: 10
    t.string   "phone",       limit: 15
    t.string   "fax",         limit: 15
    t.string   "license",     limit: 12
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "active"
    t.integer  "dept_number"
    t.string   "initials",        limit: 3
    t.string   "username"
    t.string   "password_digest"
    t.string   "notes"
    t.string   "employee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "last_name"
    t.string   "first_name"
    t.integer  "role_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "wings", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "pharmacy_id"
    t.integer  "facility_id"
    t.integer  "pass_times_id"
    t.boolean  "active"
    t.string   "name",                                 limit: 30
    t.string   "contact",                              limit: 30
    t.integer  "price_schedules",                                                                      array: true
    t.decimal  "universal_fee",                                   precision: 4, scale: 2
    t.decimal  "unit_dose_fee",                                   precision: 4, scale: 2
    t.decimal  "control_drug_fee",                                precision: 4, scale: 2
    t.decimal  "narcotic_fee",                                    precision: 4, scale: 2
    t.boolean  "allow_customer_discount"
    t.string   "label_type",                           limit: 2
    t.boolean  "spool_labels"
    t.integer  "label_default"
    t.boolean  "expiration_date"
    t.integer  "expiration_default"
    t.boolean  "lot_number"
    t.boolean  "doc_u_dose"
    t.boolean  "default_to_primary_plan"
    t.boolean  "valid_division_codes"
    t.boolean  "form_flags"
    t.boolean  "start_date"
    t.boolean  "post_zero_copay"
    t.boolean  "frequency_auto_fill"
    t.boolean  "anniversary_auto_fill"
    t.boolean  "procycle_auto_fill"
    t.integer  "print_monograph"
    t.boolean  "log_dur_results"
    t.integer  "require_hippa_privacy_notice"
    t.integer  "print_medication_guide"
    t.boolean  "print_medication_administration_form"
    t.boolean  "print_physician_order_form"
    t.boolean  "print_treatment_form"
    t.boolean  "print_delivery_receipt"
    t.string   "medication_administration_form",       limit: 12
    t.string   "physician_orders_form",                limit: 12
    t.string   "treatment_form",                       limit: 12
    t.integer  "print_order"
    t.boolean  "print_pass_times"
    t.boolean  "print_other_allergy"
    t.string   "med_administration_routine_heading",   limit: 12
    t.string   "med_administration_prn_heading",       limit: 12
    t.string   "treatment_heading",                    limit: 12
    t.boolean  "print_fill_date"
    t.boolean  "print_original_date"
    t.boolean  "print_in_frequency_order"
    t.boolean  "require_rx_copy_in_facility"
    t.boolean  "expand_sig_codes"
    t.text     "standing_orders"
    t.integer  "type_of_facility"
    t.boolean  "emr_interface"
    t.string   "emr_interface_type",                   limit: 20
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  add_index "wings", ["facility_id"], name: "index_wings_on_facility_id", using: :btree

  add_foreign_key "account_postings", "accounts"
  add_foreign_key "beds", "customers"
  add_foreign_key "beds", "facilities"
  add_foreign_key "beds", "residencies"
  add_foreign_key "beds", "wings"
  add_foreign_key "claim_clinicals", "claims"
  add_foreign_key "claim_clinicals", "dispenses"
  add_foreign_key "claim_cob_responses", "claims"
  add_foreign_key "claim_cobs", "claims"
  add_foreign_key "claim_coupons", "claims"
  add_foreign_key "claim_durs", "claims"
  add_foreign_key "claim_preferences", "claims"
  add_foreign_key "claim_prior_auths", "claims"
  add_foreign_key "claims", "customers"
  add_foreign_key "claims", "dispenses"
  add_foreign_key "claims", "plans"
  add_foreign_key "claims", "prescriptions"
  add_foreign_key "customer_allergies", "customers"
  add_foreign_key "customer_diagnoses", "customers"
  add_foreign_key "customer_plans", "customers"
  add_foreign_key "customer_wellnesses", "customers"
  add_foreign_key "customers", "facilities"
  add_foreign_key "customers", "person_images"
  add_foreign_key "customers", "prescribers"
  add_foreign_key "dispense_compound_items", "dispense_compounds"
  add_foreign_key "dispense_compounds", "dispenses"
  add_foreign_key "dispenses", "customers"
  add_foreign_key "dispenses", "items"
  add_foreign_key "dispenses", "prescriptions"
  add_foreign_key "dispenses", "rx_signatures"
  add_foreign_key "employees", "person_images"
  add_foreign_key "formulas", "items"
  add_foreign_key "ingredients", "formulas"
  add_foreign_key "ingredients", "items"
  add_foreign_key "inventories", "items"
  add_foreign_key "item_pedigrees", "items"
  add_foreign_key "item_pedigrees", "suppliers"
  add_foreign_key "items", "cdb_monographs"
  add_foreign_key "plan_requirements", "plans"
  add_foreign_key "pos_categories", "pos_taxes"
  add_foreign_key "prescribers", "person_images"
  add_foreign_key "prescriptions", "customers"
  add_foreign_key "prescriptions", "items"
  add_foreign_key "prescriptions", "prescribers"
  add_foreign_key "prescriptions", "rx_images"
  add_foreign_key "price_breaks", "price_schedules"
  add_foreign_key "price_histories", "employees"
  add_foreign_key "price_histories", "items"
  add_foreign_key "residencies", "customers"
  add_foreign_key "residencies", "facilities"
  add_foreign_key "rx_payments", "dispenses"
  add_foreign_key "suppliers", "organization_images"
  add_foreign_key "wings", "facilities"
end
