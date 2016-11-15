require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'
require 'prawn-print'

class Label < Print

  include Prawn::View

  # Basic constants for text layout
  PAGE_SIZE = "LETTER"
  PIX_INCH = 72
  MARGIN = 4
  PAD = 6
  FONT = "Courier"
  FONT_L = 12.5
  FONT_M = 10
  FONT_MS = 8.75
  FONT_S = 7.5
  SPACING = 0
  SPACE_LESS = -2
  CHAR_SPACING = -0.5
  BAR_W = 0.75
  BAR_H = 12.5

  # Width and height assuming a 8.5 x 11 in. page
  WIDTH = ( PIX_INCH * 8.5 ) - ( MARGIN * 2 )
  HEIGHT = ( PIX_INCH * 11 ) - ( MARGIN * 2 )

  # Deals with rendering the pdf in Prawn, the file name is label with a timestamp
  # Assume at least 1 label
  def to_pdf
    # Stop saving the file locally
    #time = Time.now.utc.iso8601.gsub( /\W/, '' )
    #report_dest = "#{Rails.root}/app/labels/label#{time}.pdf"

      @disp = Dispense.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num )

      build_label
      @my_prawn_doc.autoprint

      label = @my_prawn_doc.render

      (1..@params.label_count).each do |label_number|

        # filename *.pdf where * =>  company_pharmacy_rxNumber_fillno_yyyymmddhhmmss.pdf
        # hh (hours) is 24 hour clock
        filename = @disp.company_id.to_s +
            "_" + @disp.pharmacy_id.to_s +
            "_" + @disp.rx_number.to_s +
            "_" + @disp.fill_number.to_s +
            "_" + Time.now.strftime("%Y%m%d%H%M%S") +
            "_" + label_number.to_s +
            ".pdf"
        pdfFile = File.join(Rails.root, "phx_print_queue_files", filename)

        file = File.open(pdfFile, 'wb')
        file.write( label )
        file.close

      end

    #render_file report_dest
    #return report_dest
  end

  # This method assigns the page size and margins to our document
  def document
    @my_prawn_doc ||= Prawn::Document.new( page_size: PAGE_SIZE, margin: MARGIN )
  end

# TODO: Dane to fix the dates below
# TODO: Dane to fix rx options below
  # Grabs all of the necessary information from the database
  def grab_data
    # Switch variables
    # @rx_options = Rxoption.find_by( company_id: @disp.company_id, pharmacy_id: @disp.pharmacy_id )
    @rx_options = Rxoption.find_by( company_id: 1, pharmacy_id: 1 )
    # @refill_thru_date = @rx_options.refill_thru_date
    # @enter_expiration_date = @rx_options.enter_expiration_date
    # @enter_discard_date = @rx_options.enter_discard_date
    @refill_thru_date = Date.today
    @enter_expiration_date = Date.today
    @enter_discard_date = Date.today
    # @enter_lot_number = @rx_options.enter_lot_number
    # @manual_counseling = @rx_options.manual_counseling
    # @print_discount_on_label = @rx_options.print_discount_on_label
    # @print_barcode_on_label = @rx_options.print_barcode_on_label
    # @print_barcode_on_receipt = @rx_options.print_barcode_on_receipt
    # @print_store_heading = @rx_options.print_store_heading
    # @print_warning_labels = @rx_options.print_warning_labels

    @enter_lot_number = 111
    @manual_counseling = true
    @print_discount_on_label = true
    @print_barcode_on_label = false
    @print_barcode_on_receipt = true
    @print_store_heading = true
    @print_warning_labels = false

    # Dispense attributes
    @pharmacist = @disp.pharmacist_initials
    @pharmacist_full = Employee.find_by( initials: @pharmacist, employee_title: "Pharmacist" )
    if( @pharmacist_full != nil )
      @pharmacist_full = @pharmacist_full.first_name + " " + @pharmacist_full.last_name
    else
      @pharmacist_full = @pharmacist
    end
    @dispensed = @disp.quantity
    @fill_num = @disp.fill_number
    @last_filled = @disp.fill_time
    if( @last_filled != nil )
      @last_filled = @last_filled.strftime( "%m/%d/%y" )
    end
    @discard_date = @disp.discard_date
    if( @discard_date != nil )
      @discard_date = @discard_date.strftime( "%m/%d/%y" )
    end
    if( @disp.base_cost != nil )
      @cost = @disp.base_cost
    else
      @cost = 0.00
    end
    if( @disp.base_cost != nil )
      @awp = @disp.base_cost
    else
      @awp = 0.00
    end
    if( @disp.price != nil )
      @price = @disp.price
    else
      @price = 0.00
    end
    if( @disp.fee != nil )
      @fee = @disp.fee
    else
      @fee = 0.00
    end
    if( @disp.discount != nil )
      @discount = @disp.discount
    else
      @discount = 0.00
    end

    # Pricing attributes
    # @cash_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, plan_id_code: 0 )
    # @credit_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, plan_id_code: 1 )
    # @third_party_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, payor_sequence: 1 )
    @cash_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, plan_id_code: 0 )
    @credit_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, plan_id_code: 1 )
    @third_party_plan = RxPayment.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num, payor_sequence: 1 )

    if( @third_party_plan == @cash_plan )
      @plan = "CASH"
      @plan_id = @plan
      @plan_amount = @cash_plan.amount_paid
      @copay = ""
    elsif( @third_party_plan == @credit_plan )
      @plan = "CHARGE"
      @plan_id = @plan
      @plan_amount = @credit_plan.amount_paid
      @copay = ""
    else
      @code = @third_party_plan.plan_id_code
      @plan = Plan.find_by( plan_id_code: @code ).abbreviated_name
      @plan_id = "PT " + @code.to_s + " " + @plan
      @plan_amount = @third_party_plan.amount_paid
      if( @cash_plan )
        @copay = @cash_plan.amount_paid
      elsif( @credit_plan )
        @copay = @credit_plan.amount_paid
      else
        @copay = 0.00
      end
    end

    # Prescription attributes
    @rx_number = @disp.prescription.rx_number
    @directions = @disp.prescription.directions
    @days = @disp.days_supply
    @daw = @disp.prescription.dispense_as_written_code.to_i
    @refills = @disp.prescription.refills_prescribed
    @remaining = @refills - @fill_num
    @written = @disp.prescription.date_written
    if( @written != nil )
      @written = @written.strftime( "%m/%d/%y" )
    end
    @expires = @disp.prescription.expiration_date
    if( @expires != nil )
      @expires = @expires.strftime( "%m/%d/%y" )
    end
    @refill_thru = @disp.prescription.last_fill_date
    if( @refill_thru != nil )
      @refill_thru = @refill_thru.strftime( "%m/%d/%y" )
    end

    # Customer attributes
    @patient = @disp.prescription.customer.first_name + " " + ( @disp.prescription.customer.middle_name.blank? ?
      @disp.prescription.customer.last_name : @disp.prescription.customer.middle_name + " " +
      @disp.prescription.customer.last_name )
    if( @disp.prescription.customer.address2 and @disp.prescription.customer.address2 != "" )
      @patient_addr = @patient + "\n" + @disp.prescription.customer.address1 + "\n" + @disp.prescription.customer.address2 +
      "\n" + @disp.prescription.customer.city + ", " + @disp.prescription.customer.state + " " +
      @disp.prescription.customer.zip_code
      @patient_addr_gap = @patient_addr
      @patient_addr_short = @disp.prescription.customer.address1 + ", " + @disp.prescription.customer.address2 +
      ", " + @disp.prescription.customer.city + ", " + @disp.prescription.customer.state + " " +
      @disp.prescription.customer.zip_code
    else
      @patient_addr = @patient + "\n" + @disp.prescription.customer.address1 + "\n" + @disp.prescription.customer.city + ", " +
      @disp.prescription.customer.state + " " + @disp.prescription.customer.zip_code
      @patient_addr_gap = @patient + "\n" + @disp.prescription.customer.address1 + "\n\n" + @disp.prescription.customer.city +
      ", " + @disp.prescription.customer.state + " " + @disp.prescription.customer.zip_code
      @patient_addr_short = @disp.prescription.customer.address1 + ", " + @disp.prescription.customer.city + ", " +
      @disp.prescription.customer.state + " " + @disp.prescription.customer.zip_code
    end
    if( @disp.prescription.customer.childproof_cap )
      @childproof = "Y"
    else
      @childproof = "N"
    end

    # @patient_phone = @disp.prescription.customer.phone_number.first
    # if( @patient_phone != nil )
    #   @patient_phone = @patient_phone.phone_number.to_s
    # else
    #   @patient_phone = ""
    # end
    @patient_phone = "9999999999"
    @patient_birth = @disp.prescription.customer.birthdate
    if( @patient_birth != nil )
      @patient_birth = "#{@patient_birth.strftime('%m/%d/%y')}"
    else
      @patient_birth = ""
    end

    # Prescriber attributes
    @doctor = "DR #{@disp.prescription.prescriber.first_name} " + ( @disp.prescription.prescriber.middle_name.blank? ?
      @disp.prescription.prescriber.last_name : @disp.prescription.prescriber.middle_name + " " +
      @disp.prescription.prescriber.last_name )
    @doctor_abbr = "DR #{@disp.prescription.prescriber.last_name},#{@disp.prescription.prescriber.first_name[0,4]}"
    if( @disp.prescription.prescriber.address2 and @disp.prescription.prescriber.address2 != "" )
      @doctor_addr = @doctor + "\n" + @disp.prescription.prescriber.address1 + "\n" + @disp.prescription.prescriber.address2 +
      "\n" + @disp.prescription.prescriber.city + ", " + @disp.prescription.prescriber.state + " " +
      @disp.prescription.prescriber.zip_code
      @doctor_addr_short = @disp.prescription.prescriber.address1 + ", " + @disp.prescription.prescriber.address2 +
      ", " + @disp.prescription.prescriber.city + ", " + @disp.prescription.prescriber.state + " " +
      @disp.prescription.prescriber.zip_code
    else
      @doctor_addr = @doctor + "\n" + @disp.prescription.prescriber.address1 + "\n" + @disp.prescription.prescriber.city +
      ", " + @disp.prescription.prescriber.state + " " + @disp.prescription.prescriber.zip_code
      @doctor_addr_short = @disp.prescription.prescriber.address1 + ", " + @disp.prescription.prescriber.city +
      ", " + @disp.prescription.prescriber.state + " " + @disp.prescription.prescriber.zip_code
    end
    @facility = @disp.prescription.prescriber.facility_number
    if( @disp.prescription.prescriber.dea_number != nil )
      @dea = "#{@disp.prescription.prescriber.dea_number}"
    else
      @dea = "\n"
    end
    if( @disp.prescription.prescriber.npi_number != nil )
      @npi = "NPI #{@disp.prescription.prescriber.npi_number}"
    else
      @npi = "\n"
    end
    # @doctor_phone = @disp.prescription.prescriber.phones.first
    # if( @doctor_phone != nil )
    #   @doctor_phone = @doctor_phone.phone.to_s
    # else
      @doctor_phone = "9999999999"
    # end

    # Item attributes
    @drug = Item.find_by( id: @disp.item_id ).item_name
    # @drug = Item.find_by( id: 15282 ).item_name
    @rx_drug = Item.find_by( id: @disp.prescription.item_id ).item_name
    # @rx_drug = Item.find_by( id: 2 ).item_name
    if( @drug == @rx_drug )
      @generic = "\n"
    else
      @generic = "Generic for #{@rx_drug}"
    end
    @ndc = Item.find_by( id: @disp.item_id ).ndc_number
    # @ndc = Item.find_by( id: 15282 ).ndc_number
    # @mono_drug_name = CdbDrugReference.find_by( ndc_number: @ndc ).drug_name
    @mono_drug_name = Item.find_by( ndc_number: @ndc ).item_name
    puts @mono_drug_name
    # @manufacturer = CdbDrugReference.find_by( ndc_number: @ndc )
    @manufacturer = Item.find_by( ndc_number: @ndc )
    if( @manufacturer != nil )
      @manufacturer = @manufacturer.mfg_name.strip!
    else
      @manufacturer = ""
    end
    @ndc = @ndc.to_s
    @sched = Item.find_by( id: @disp.item_id ).schedule_number.to_s
    # @sched = Item.find_by( id: 15282 ).schedule_number.to_s

    # Other attributes
    # Barby not playing well with Prawn, new object created but not passed to label_a
    # @barcode = Barby::Code39.new @params.rx_number
    # @barcode = Barby::Code39.new( "1427220" )
    @claim = Claim.find_by( rx_number: @params.rx_number, fill_number: @params.fill_num )
    # @claim = Claim.find_by( rx_number: 1427220, fill_number: 0 )
    if( @claim )
      @claim = @claim.authorization_number
    end
    # @monograph = CdbMonograph.find_by( company_id: @disp.company_id, pharmacy_id: @disp.pharmacy_id, drug_name: @mono_drug_name )
    # if( @monograph != nil )
    #   @pronunciation = @monograph.pronunciation.to_s
    #   @other_names = "COMMON BRAND NAME(S): " + @monograph.us_brand_name.to_s
    #   @uses = "USES: " + @monograph.used_for.to_s
    #   @warning = "WARNING: " + @monograph.warning.to_s
    #   @disclaimer = "DISCLAIMER: " + @monograph.disclaimer.to_s
    # else
    #   @pronunciation = ""
    #   @other_names = ""
    #   @uses = ""
    #   @warning = ""
    #   @disclaimer = ""
    # end
  end

  # Adds the pharmacy heading to the label
  def add_heading( x, y, width, height )
    bounding_box( [x, y], width: width, height: height ) do
      if( @print_store_heading )
        text "SOUTHEAST GEORGIA HOSPITAL SYSTEM
              2415 Parkwood Dr., Brunswick GA
              Phone (912) 555-1212"
      end
  end
end

  # Trims the trailing decimals of a given number
  def trim( num )
    i, f = num.to_i, num.to_f
    i == f ? i : f
  end
end
