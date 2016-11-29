class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def plan
		@plan = Plan.new
  end

  # GET /plans
  # GET /plans.json
  def index
    redirect_to :controller => 'searches', :action => 'new', :searching_for => 'plan'
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    render :edit
  end

  def search
    bin_number = params[:bin_number]
    plan_name  = params[:plan_name]
    pageNumber = params[:page] ? params[:page] : 1
    perPage = 9
    case bin_number
      when /^\d{6}$/      #6 digit bin number
        @searchPlans = Plan.search_by_partial(bin_number).page(pageNumber).per(perPage)
      else
        @searchPlans = Plan.search_by_plan_name(plan_name).page(pageNumber).per(perPage)
    end
    render  template: 'common/search/js/nextSearchPlans.js'
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
      @segment_ary =
      {
          'patient' =>
            [
                [
                    :patient_birthdate,
                    :patient_gender,
                    :patient_first_name,
                    :patient_last_name,
                    :patient_address,
                    :patient_city,
                    :patient_state,
                    :patient_zip_code,
                    :patient_phone,
                    :patient_residence_code,
                    :patient_location_code,
                    :patient_smoker,
                    :patient_pregnant,
                    :patient_email,
                    :patient_employer_id,
                    :patient_universal_id
                ],
                [
                    'patient birthdate',
                    'patient gender',
                    'patient first name',
                    'patient last name',
                    'patient address',
                    'patient city',
                    'patient state',
                    'patient zip code',
                    'patient phone',
                    'patient residence code',
                    'patient location code',
                    'patient smoker',
                    'patient pregnant',
                    'patient email',
                    'patient employer id',
                    'patient universal id'
                ]
            ],
          'insurance' =>
            [
                [
                    :cardholder_id_number,
                    :group_id_number,
                    :plan_id_number,
                    :person_code,
                    :cardholder_first_name,
                    :cardholder_last_name,
                    :relationship_code,
                    :home_plan,
                    :eligibility_code,
                    :facility_id_number,
                    :medigap_indicator,
                    :assignment_indicator,
                    :partd_indicator,
                    :medicaid_indicator,
                    :medicaid_id_number
                ],
                [
                    'cardholder id number',
                    'group id number',
                    'plan id number',
                    'person code',
                    'cardholder first name',
                    'cardholder last name',
                    'relationship code',
                    'home plan',
                    'eligibility code',
                    'facility id number',
                    'medigap indicator',
                    'assignment indicator',
                    'partd indicator',
                    'medicaid indicator',
                    'medicaid id number'
                ]
            ],
          'prescription1' =>
            [
                [
                    :fill_number,
                    :days_supply,
                    :dispense_as_written_code,
                    :quantity_dispensed,
                    :date_written,
                    :refills_prescribed,
                    :origin_code,
                    :compound_indicator,
                    :compound_type,
                    :product_id_number_qualifier,
                    :product_id_number,
                    :route_of_administration,
                    :pharmacy_type,
                    :denial_override_code,
                    :denial_override_count,
                    :quantity_prescribed,
                    :other_coverage,
                    :regular_prior_authorization,
                    :regular_prior_authorization_type,
                    :dispense_status
                    # :intermediary_authorixation
                ],
                [
                    'fill number',
                    'days supply',
                    'dispense as written code',
                    'quantity dispensed',
                    'date written',
                    'refills prescribed',
                    'origin code',
                    'compound indicator',
                    'compound type',
                    'product id number qualifier',
                    'product id number',
                    'route of administration',
                    'pharmacy type',
                    'denial override code',
                    'denial override count',
                    'quantity prescribed',
                    'other coverage',
                    'regular prior authorization',
                    'regular prior authorization type',
                    'dispense status'
                # 'intermediary authorixation'
                ]
            ],
          'prescription2' =>
            [
                [
                    :intended_quantity,
                    :intended_days_supply,
                    :level_of_service,
                    :unit_of_measure,
                    :unit_dose_indicator,
                    :delay_code,
                    :dea_blank_number,
                    :patient_rx_assignment,
                    :alternate_id_number,
                    :original_product_id_number,
                    :original_quantity_prescribed,
                    :associated_rx_number,
                    :associated_date,
                    :procedure_modifier,
                    :intermediary_type,
                # :intermediary_authorixation
                ],
                [
                    'intended quantity',
                    'intended days supply',
                    'level of service',
                    'unit of measure',
                    'unit dose indicator',
                    'delay code',
                    'dea blank number',
                    'patient rx assignment',
                    'alternate id number',
                    'original product id number',
                    'original quantity prescribed',
                    'associated rx number',
                    'associated date',
                    'procedure modifier',
                    'intermediary type',
                # 'intermediary authorixation'
                ]
            ],
          'prescriber' =>
            [
                [
                    :prescriber_id_number_qualifier,
                    :prescriber_first_name,
                    :prescriber_last_name,
                    :prescriber_address,
                    :prescriber_city,
                    :prescriber_state,
                    :prescriber_zip_code,
                    :prescriber_phone_number,
                    :prescriber_location,
                    :primary_prescriber_id_qualifier,
                    :primary_prescriber_last_name,
                    :primary_prescriber_location
                ],
                [
                    'prescriber id number qualifier',
                    'prescriber first name',
                    'prescriber last name',
                    'prescriber address',
                    'prescriber city',
                    'prescriber state',
                    'prescriber zip code',
                    'prescriber phone number',
                    'prescriber location',
                    'primary prescriber id qualifier',
                    'primary prescriber last name',
                    'primary prescriber location'

                ]
            ],
          'coordination' =>
            [
                [
                    :other_payor_count,
                    :other_payor_coverage_type,
                    :other_payor_id_number,
                    :other_payor_date,
                    :other_payor_amount_paid,
                    :other_payor_reject_count,
                    :other_payor_reject_code,
                    :other_payor_patient_amount_count,
                    :other_payor_patient_amount_qualifier,
                    :other_payor_patient_amount,
                    :other_payor_benefit_count,
                    :other_payor_benefit_qualifier,
                    :other_payor_benefit_amount,
                    :other_payor_control_number
                ],
                [
                    'other payor count',
                    'other payor coverage type',
                    'other payor id number',
                    'other payor date',
                    'other payor amount paid',
                    'other payor reject count',
                    'other payor reject code',
                    'other payor patient amount count',
                    'other payor patient amount qualifier',
                    'other payor patient amount',
                    'other payor benefit count',
                    'other payor benefit qualifier',
                    'other payor benefit amount',
                    'other payor control number'
                ]
            ],
          'drug' =>
            [
                [
                    :dur_counter,
                    :dur_reason_code,
                    :dur_service_code,
                    :dur_result_code,
                    :dur_effort_code,
                    :dur_coagent
                ],
                [
                    'dur counter',
                    'dur reason code',
                    'dur service code',
                    'dur result code',
                    'dur effort code',
                    'dur coagent'
                ]
            ],
          'pricing' =>
            [
                [
                    :base_cost,
                    :dispensing_fee,
                    :service_fee,
                    :copay,
                    :incentive_fee,
                    :other_amount,
                    :flat_tax_amount,
                    :pct_tax_amount,
                    :tax_rate,
                    :tax_basis,
                    :usual_customary_price,
                    :amount_due,
                    :basis_of_cost,
                    :price_override
                ],
                [
                    'base cost',
                    'dispensing fee',
                    'service fee',
                    'copay',
                    'incentive fee',
                    'other amount',
                    'flat tax amount',
                    'pct tax amount',
                    'tax rate',
                    'tax basis',
                    'usual customary price',
                    'amount due',
                    'basis of cost',
                    'price override'
                ]
            ],
          'compound' =>
            [
                [
                    :dosage_form,
                    :dispensing_unit,
                    :route_of_administration,
                    :ingredient_id_number,
                    :ingredient_quantity_dispensed,
                    :ingredient_cost,
                    :ingredient_cost_basis,
                    :ingredient_modifier_count,
                    :ingredient_modifier
                ],
                [
                    'dosage form',
                    'dispensing unit',
                    'route of administration',
                    'ingredient id number',
                    'ingredient quantity dispensed',
                    'ingredient cost',
                    'ingredient cost basis',
                    'ingredient modifier count',
                    'ingredient modifier'
                ]
            ],
          'compensation' =>
            [
                [
                    :date_of_injury,
                    :employer_name,
                    :employer_address,
                    :employer_city,
                    :employer_state,
                    :employer_zip_code,
                    :employer_phone,
                    :employer_contact,
                    :carrier_id_number,
                    :employer_reference_id,
                    :employer_type,
                    :pay_to_qualifier,
                    :pay_to_id_number,
                    :pay_to_name,
                    :pay_to_address,
                    :pay_to_city,
                    :pay_to_state,
                    :pay_to_zip_code,
                    :general_id_qualifier,
                    :general_id_number
                ],
                [
                    'date of injury',
                    'employer name',
                    'employer address',
                    'employer city',
                    'employer state',
                    'employer zip code',
                    'employer phone',
                    'employer contact',
                    'carrier id number',
                    'employer reference id',
                    'employer type',
                    'pay to qualifier',
                    'pay to id number',
                    'pay to name',
                    'pay to address',
                    'pay to city',
                    'pay to state',
                    'pay to zip code',
                    'general id qualifier',
                    'general id number'
                ]
            ],
          'prior_authorization' =>
            [
                [
                    :request_type,
                    :request_begin_date,
                    :request_end_date,
                    :request_basis,
                    :representative_first_name,
                    :representative_last_name,
                #    :submit_reoresentative_address,
                    :representative_city,
                    :representative_state,
                    :representative_zip_code,
                    :prior_authorization_assigned,
                    :prior_authorization_number,
                  #  :prior_authorixation_prescriber
                ],
                [
                    'request type',
                    'request begin date',
                    'request end date',
                    'request basis',
                    'representative first name',
                    'representative last name',
                   # 'submit reoresentative address',
                    'representative city',
                    'representative state',
                    'representative zip code',
                    'prior authorization assigned',
                    'prior authorization number',
                   # 'prior authorixation prescriber'
                ]
            ],
          'clinical' =>
            [
                [
                    :diagnosis_count,
                    :diagnosis_code,
                    :clinical_count,
                    :clinical_date,
                    :clinical_time,
                    :clinical_dimension,
                    :clinical_unit,
                    :clinical_value
                ],
                [
                    'diagnosis count',
                    'diagnosis code',
                    'clinical count',
                    'clinical date',
                    'clinical time',
                    'clinical dimension',
                    'clinical unit',
                    'clinical value'
                ]
            ],
          'coupon' =>
            [
                [
                    :coupon_type,
                    :coupon_number,
                    :coupon_amount,
                ],
                [
                    'coupon type',
                    'coupon number',
                    'coupon amount'
                ]
            ],
          'pharmacy' =>
            [
                [
                    :secondary_provider_id_qualifier,
                    :secondary_provider_id_number
                ],
                [
                    'secondary provider id qualifier',
                    'secondary provider id number'
                ]
            ]
      }
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:dept_number, :rna_plan_id_code, :insurance_plan_name, :abbreviated_name, :active_flag, :plan_type, :payor_type, :print_sort_code, :provider_number, :account_number, :address1, :address2, :city, :state, :zip_code, :extra_unit_dose_fee, :extra_ctrl_fee, :extra_narcotic_fee, :extra_delivery_fee, :extra_ancillary_fee, :patient_price_schedule_apply, :copay_type, :adjudicate_claims, :do_discounts_apply, :support_split_billing, :split_bill_format, :authorization_on_label, :plan_info_on_label, :submit_as_cash)
    end
end
