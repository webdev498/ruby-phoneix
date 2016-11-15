class PrescriptionsController < ApplicationController

    before_action :set_prescription, only: [:show, :edit, :update, :destroy]


    # ajax answer the next page for paginated Customer search
    def nextCustomers
      @searchCustomers = Customer.nextActiveCustomers params[:start], params[:page], 9
      @searchController = "prescriptions"
      render  template: 'common/search/js/nextSearchCustomers.js'
    end

    # ajax answer the next page for paginated Prescriber search
    def nextPrescribers
        @searchPrescribers = Prescriber.nextActivePrescribers params[:start], params[:page], 9
        @searchController = "prescriptions"
        render  template: 'common/search/js/nextSearchPrescribers.js'
    end

    # ajax answer the next page for paginated Item search
    def nextItems
        @searchItems = Item.nextActiveItems params[:start], params[:page], 9
        @searchController = "prescriptions"
        render  template: 'common/search/js/nextSearchItems.js'
    end

    # ajax answer the next page for paginated Prescription (Profile) search
    def nextPrescriptions
        nextPage = params[:page] ? params[:page].to_i : 1
        @searchPrescriptions = Customer.find( params[:startId].to_i ).prescriptions.page(nextPage).per(9)
        render  template: 'common/search/js/nextSearchPrescriptons.js'
    end


    # ajax answer the next page for paginated Dispense search
    # the id is the selected prescription from the profile
    def nextDispenses
        nextPage = params[:page] ? params[:page].to_i : 1
        @searchDispenses = Prescription.find( params[:startId].to_i ).dispenses.page(nextPage).per(9)
        @searchController = "prescriptions"
        render  template: 'common/search/js/nextSearchDispenses.js'
    end


    def refreshSigCache
        sigCache = Sigcode.all
        # test with 10 codes
        render json: sigCache.collect { |sig|
            { code: sig.sig_code, expanded: sig.expanded_text, freq: sig.frequency } }
    end


    # ******* improvement listed below is to be used in the above searches for performance improvement
    # ******* not to be implemented until later in the product development
    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
    #    searchTemplate = render_to_string partial: 'common/search/prescriber_search_modal_template', locals: { searchPrescribers: @searchPrescribers }, :layout => false
    # when using the technique above, the newlines (\n) have to be removed
    #    render js: "$('#prescriber_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

    def new_rxVerification
      @prescription = Prescription.new
    	render 'verifyPrescription'
    end


    # TODO: need to bring in the modal searches
    def rxVerification
        if (prescription = Prescription.find_by_rx_number( params[:rx_number] )).nil?
            format.html { redirect_to rxVerification_url, notice: 'Prescription not found.' }
        end
        dispense = Dispense.find_by_rx_number params[:rx_number]
        @match_status = (prescription.item.id == dispense.item.id) ? "MATCH SUCCESSFUL" : "NO MATCH"
        render 'verifyPrescription'
    end


    # GET /prescriptions/1
    # GET /prescriptions/1.json
    def show
        show_prescription
        render :edit
    end


  # GET /prescriptions/1
  # GET /prescriptions/1.json
  def show_rx_prescription
		if (@prescription = Prescription.find_by_rx_number( params[:rx_number] )).nil?
  			@prescription = Prescription.new
		end

    @prescription.customer = Customer.new      if @prescription.customer.nil?
    @prescription.item = Item.new              if @prescription.item.nil?
    @prescription.prescriber = Prescriber.new  if @prescription.prescriber.nil?

    # set up display fields
		show_prescription

		render :edit
  end


  def show_prescription
      # set up display fields
      @prescription.customer_display_name = @prescription.customer.display_name
      @prescription.prescriber_display_name = @prescription.prescriber.display_name
      @prescription.prescriber_npi_number = @prescription.prescriber.npi_number
      @prescription.prescriber_dea_number = @prescription.prescriber.dea_number
      @prescription.prescriber_phone      = @prescription.prescriber.prescribing_phone

      @prescription.rxForm_daily_quantity = @prescription.daily_quantity
      @prescription.rxForm_days_supply    = @prescription.last_fill_days_supply
      @prescription.payment_type          = @prescription.last_fill_primary_paytype
      @prescription.prescription_price    = @prescription.last_fill_price

      @prescription.item_display_name  = @prescription.item.item_name
      @prescription.item_ndc_number    = @prescription.item.ndc_number
      @prescription.item_package_size  = @prescription.item.package_size
      @prescription.customer_birthdate = @prescription.customer.birthdate.to_phxDateString  # proper format for readonly date in textfield

      @prescription.customer_age       = @prescription.customer.age
      @prescription.customer_gender    = @prescription.customer.gender
      @prescription.customer_phone     = @prescription.customer.phone_number
      @prescription.quantity_on_hand   = @prescription.item.quantity_on_hand

#   @prescription.expiration_date = @prescription.expiration_date.to_phxDateString  # proper format for readonly date in textfield
#		@prescription.refill_through = @prescription.item.refill_through
  end


    # GET /prescriptions/new
    # prepare for new prescription
    def new
      @prescription = Prescription.new
    end


  # GET /prescriptions/1/edit
  def edit
  end


  # POST /prescriptions
  def create

    user = User.find session[:user_id]
    session_rph_intials = session[:initials]

    # temporarily disabled ... waiting for Steve's decision
    # return if !phx_authorized user, :usr_rph, :prescription

    if params[:fill] && params[:action]=="create"

        rxo = Rxoption.first  # there should always only be 1 record in this table
        rxo.last_new_rx_number += 1

        rxParams = params[:prescription]

        # convert enums to integers
        rxParams[:dispense_as_written_code] = rxParams[:dispense_as_written_code].to_i
        rxParams[:origin_code] = rxParams[:origin_code].to_i
        rxParams[:rx_type]     = rxParams[:rx_type].to_i

        # use strong parameters for the time being
        @prescription = Prescription.new(prescription_params)
        pharmacist_initials = rxParams[:pharmacist_initials].upcase
        technician_initials = rxParams[:technician_initials].upcase

        fill = @prescription.fill Date.today, rxo.last_new_rx_number, rxParams, pharmacist_initials, technician_initials

        if fill
            @prescription.dispenses << fill
            if @prescription.save

              # Create a payment based on the dispense
              payment = RxPayment.payment_from_dispense fill
              payment.save

              # need safety check here ... even though its only 1 attribute ... needs to be part of a transaction
              rxo.save

              print_label rxParams[:labels].to_i

              redirect_to new_prescription_url and return true
            end
        # TODO: not dry, fix the code below
        else
          redirect_to action: "new"
        end
    end
  end


  # refill
  # PATCH/PUT /prescriptions/1
  # PATCH/PUT /prescriptions/1.json
  def update

    user = User.find session[:user_id]
    session_rph_intials = session[:initials]
    # temporarily disabled
    # return if !phx_authorized user, :usr_rph, :prescription

    rxo = Rxoption.first

    case

    # refill
    when params[:fill] && params[:action]=="update"

        @prescription = Prescription.find params[:id]
        last_dispense = @prescription.dispenses.max_by {|dispense| dispense.fill_number }

        pharmacist_initials = params[:prescription][:pharmacist_initials].upcase
        technician_initials = params[:prescription][:technician_initials].upcase

        refillDispense = @prescription.refill last_dispense, Date.today, nil, params[:prescription], pharmacist_initials, technician_initials

        if refillDispense

            @prescription.dispenses << refillDispense

            if @prescription.save

              # Create a payment based on the dispense
              payment = RxPayment.payment_from_dispense refillDispense
              payment.save

              # need safety check here ... even though its only 1 attribute ... needs to be part of a transaction
              rxo.save

              print_label  params[:prescription][:labels].to_i

              redirect_to new_prescription_url and return true
            end

          # TODO: not dry, fix the code below
        else
          redirect_to action: "new"
        end

    # update the prescription
    when params[:updatePrescription] && params[:action]=="update"
        # TODO: future: need to retire this section since its will be in another method

        @prescription.item = Item.find params[:prescription][:item_id].to_i  if params[:prescription][:item_id]!=""
        @prescription.prescriber = Prescriber.find params[:prescription][:prescriber_id].to_i  if params[:prescription][:prescriber_id]!=""

        params[:prescription][:dispense_as_written_code] = params[:prescription][:dispense_as_written_code].to_i
        params[:prescription][:origin_code] = params[:prescription][:origin_code].to_i

        params[:prescription][:status] = params[:prescription][:status].to_i
        params[:prescription][:rx_type] = params[:prescription][:rx_type].to_i

        pharmacist_initials = params[:prescription][:pharmacist_initials].upcase
        technician_initials = params[:prescription][:technician_initials].upcase

        respond_to do |format|
            if @prescription.update(prescription_params)
              format.html { redirect_to findPrescription_path }
            else
              format.html { render :edit }
            end
        end

    # update the dispense
    # TODO:  move this to the dispense controller
    # TODO:  only dispense; primary info is not changed
    when params[:updateDispense] && params[:action]=="update"

            dispense_params = params[:prescription][:dispense]
            disp = Dispense.find params[:updated_dispense_id]

            disp.pharmacist_initials = dispense_params[:pharmacist_initials].upcase
            disp.technician_initials = dispense_params[:technician_initials].upcase

            # disp.fill_number would be here - not allowed - will screw up database relations

            # disp.fill_time = dispense_params[:fill_time]

            disp.status = dispense_params[:status].to_i
            disp.split_bill_rx = dispense_params[:split_bill_rx]
            disp.billing_complete = dispense_params[:billing_complete]

            disp.quantity = dispense_params[:quantity]
            disp.days_supply = dispense_params[:days_supply]
            disp.delivery_route = dispense_params[:delivery_route]

            # disp.discard_date = dispense_params[:discard_date]
            disp.price = dispense_params[:price].to_f
            disp.usual_customary_price = dispense_params[:usual_customary_price]
            disp.base_cost = dispense_params[:base_cost]
            disp.acquisition_cost = dispense_params[:acquisition_cost]
            disp.fee = dispense_params[:fee]
            disp.discount = dispense_params[:discount]
            disp.tax = dispense_params[:tax]
            # disp.ancilliary_fee - current not in change view
            disp.professional_service_fee = dispense_params[:professional_service_fee]
            disp.cost_basis = dispense_params[:cost_basis]
            disp.other_coverage_code = dispense_params[:other_coverage_code]
            disp.other_amount = dispense_params[:other_amount]
            disp.other_amount_type = dispense_params[:other_amount_type]
            disp.prior_auth_type = dispense_params[:prior_auth_type]
            disp.reason_for_delay = dispense_params[:reason_for_delay]
            disp.denial_override_code = dispense_params[:denial_override_code]
            disp.partial_fill_status = dispense_params[:partial_fill_status]

            disp.lot_number = dispense_params[:lot_number]
            disp.serial_number = dispense_params[:serial_number]

            disp.save

            redirect_to findDispense_url and return true

            # respond_to do |format|
            #     format.html { redirect_to findPrescription_path }
            #     # if @prescription.update(prescription_params)
            #     #   format.html { redirect_to findPrescription_path }
            #     # else
            #     #   format.html { render :edit }
            #     # end
            # end

      else
          @prescription = Prescription.new
          redirect_to menu_prescription_url
    end

  end

  def findPrescription
    @prescription = Prescription.new
    render template: 'prescriptions/editPrescription'
  end


  def editPrescription
    @prescription = Prescription.find params[:id].to_i
    show_prescription
    render template: 'prescriptions/editPrescription'
  end


  def editPrescriptionRx
    if (@prescription = Prescription.find_by_rx_number( params[:id] )).nil?
  			@prescription = Prescription.new
		end
    show_prescription
    render template: 'prescriptions/editPrescription'
  end


  # TODO: future: route update prescription to this method
  def updatePrescription
    # not being used right now ... see bottom of create section for rx update
  end


  def findDispense
    @selectedDispense = Dispense.new  # needed for dispense edit
    @prescription = Prescription.new
    render template: 'prescriptions/editDispense'
  end


  def editDispense
    @selectedDispense = Dispense.find params[:id].to_i
    @prescription = @selectedDispense.prescription
    @prescription.pharmacist_initials = @selectedDispense.pharmacist_initials
    @prescription.technician_initials = @selectedDispense.technician_initials
    @selectedDispense.dispensed_item_name = @selectedDispense.item.item_name
    show_prescription
    render template: 'prescriptions/editDispense'
  end

# TODO:  getting csrf error - disabling locate dispense by rx_number for now
  def editDispenseRx
    params[:startId] = (Prescription.find_by_rx_number (params[:rx_number].to_i)).id
    nextDispenses
  end


  def updateDispense
    @selectedDispense = @prescription.dispenses.first
  end


  # DO NOT ALLOW PRESCRIPTION DESTROY !!!
  #
  # DELETE /prescriptions/1
  # DELETE /prescriptions/1.json
  def destroy
    # @prescription.destroy
    # respond_to do |format|
    #   format.html { redirect_to prescriptions_url, notice: 'Prescription was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: 'Prescription deletion not allowed.' }
      format.json { head :no_content }
    end
   end


   def print_label labelCount=0

        if labelCount > 0
         params = LabelParams.new( @prescription.rx_number, @prescription.last_fill_number, labelCount )

         # generate a label image
         labelA = LabelA.new( params )

         labelA.to_pdf
      end
   end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescription_params
        # these fields removed from strong parameter list - :company_id, :pharmacy_id, :customer_id, :prescriber_id, :item_id, :supervising_prescriber_id,
        params.require(:prescription).permit(:rx_number, :legacy_customer_id_number, :legacy_prescriber_id_number, :legacy_item_id_number,
        :original_refills_prescribed, :refills_prescribed, :refills_left, :original_total_quantity_prescribed, :quantity_remaining,
        :quantity_prescribed, :daily_quantity, :active, :rx_type, :rx_status, :dea_schedule, :dispense_as_written_code, :certification_code,
        :diagnosis_code, :diagnosis_code_qualifier, :prior_authorization_number, :origin_code,
        :refill_through_date, :expiration_date, :date_written, :renewed_rx_number, :renewed_rx_date,
        :retail_auto_fill_type, :retail_auto_fill_next_date, :notes, :counseling,
        :last_fill_date, :last_fill_number, :last_fill_quantity, :last_fill_days_supply, :last_fill_primary_paytype, :last_fill_price,
        :last_fill_discount, :last_fill_legacy_item_id_number, :doc_u_dose_rx, :on_docudose_calendar, :directions,
        :print_division_code, :print_on_prn, :print_on_mar, :print_on_po, :print_on_treatment, :print_on_flow, :pass_times, :auto_fill_type,
        :auto_fill_next_date, :procycle_quantity_dispensed, :procycle_quantity_left, :start_date, :stop_date, :sig_frequency, :delivery_route)
    end
end
