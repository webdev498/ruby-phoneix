class PhxErxProcessor

  include ActiveModel::Model
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	include ActiveModel::Naming

  # temporary path added for erx processing
  @@Erx_inbound_path   = Rails.root.join('../pharmacy/erx_inbound')
  @@Erx_pending_path   = Rails.root.join('../pharmacy/erx_pending')
  @@Erx_processed_path = Rails.root.join('../pharmacy/erx_processed')

   @@QueuingMap = [
    [PhxErxNode.new( "xmlns", ["Prescriber","Name","FirstName"], :ElectronicPrescription, 'received_prescriber_name'),
      PhxErxNode.new( "xmlns", ["Prescriber","Name","LastName"], :ElectronicPrescription, 'received_prescriber_name')],
    [PhxErxNode.new( "xmlns", ["Patient","Name","FirstName"], :ElectronicPrescription, 'received_customer_name'),
      PhxErxNode.new( "xmlns", ["Patient","Name","LastName"], :ElectronicPrescription, 'received_customer_name')],
    [PhxErxNode.new( "xmlns", ["MedicationPrescribed","DrugDescription"], :ElectronicPrescription, 'received_item_name')]
  ]

  def self.QueuingHeader
    @@QueuingMap
  end

  attr_accessor :document, :schema


  def initialize document_path, schema_path

    read_document(document_path)

  end


  # !!!!!
  # This is a temporary kludge while the new queue manager is implemented
  # !!!!!
  def self.load_erx_files

    # look for xml erx's
    Dir[@@Erx_inbound_path.to_s + "/*"].each do |xml_file|
      xml_open_file = File.open xml_file

      # parse the xml erx file
      xmldoc = Nokogiri::XML(xml_open_file)

      # save the erx data in the staging table
      # parsing to be driven by queuing map ... temporarily hard coded below
      messageId = xmldoc.xpath("//xmlns:Message/xmlns:Header/xmlns:MessageID").text
      prescriberFirstName = xmldoc.xpath("//xmlns:Prescriber/xmlns:Name/xmlns:FirstName").text
      prescriberLastName = xmldoc.xpath("//xmlns:Prescriber/xmlns:Name/xmlns:LastName").text
      patientFirstName = xmldoc.xpath("//xmlns:Patient/xmlns:Name/xmlns:FirstName").text
      patientLastName = xmldoc.xpath("//xmlns:Patient/xmlns:Name/xmlns:LastName").text
      drugName = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:DrugDescription").text

      ep = ElectronicPrescription.new
      ep.transmission_number = messageId
      ep.received_prescriber_name = prescriberLastName + ", " + prescriberFirstName
      ep.received_customer_name = patientLastName + ", " + patientFirstName
      ep.received_item_name = drugName[0..34]  #!!! this should not be 35 chars
      ep.xml_file_name = File.basename xml_open_file

      # needs to move to controller
      ep.save
    end

  end

  def self.parse_erx_file ep

    xml_open_file = File.open( @@Erx_inbound_path.to_s + '/' + ep.xml_file_name )

    # parse the xml erx file
    xmldoc = Nokogiri::XML(xml_open_file)

    # save the erx data in the staging table
    # parsing to be driven by queuing map ... temporarily hard coded below
    messageId = xmldoc.xpath("//xmlns:Message/xmlns:Header/xmlns:MessageID").text

    ep.prescriber_first_name   = xmldoc.xpath("//xmlns:Prescriber/xmlns:Name/xmlns:FirstName").text
    ep.prescriber_last_name    = xmldoc.xpath("//xmlns:Prescriber/xmlns:Name/xmlns:LastName").text
    ep.prescriber_middle_name  = xmldoc.xpath("//xmlns:Prescriber/xmlns:Name/xmlns:MiddleName").text
    ep.prescriber_npi_number   = xmldoc.xpath("//xmlns:Prescriber/xmlns:Identification/xmlns:NPI").text
    ep.prescriber_phone_number = xmldoc.xpath("//xmlns:Prescriber/xmlns:CommunicationNumbers/xmlns:Communication/xmlns:Number").text
    ep.clinic_city             = xmldoc.xpath("//xmlns:Prescriber/xmlns:Address/xmlns:City").text

    ep.patient_first_name   = xmldoc.xpath("//xmlns:Patient/xmlns:Name/xmlns:FirstName").text
    ep.patient_last_name    = xmldoc.xpath("//xmlns:Patient/xmlns:Name/xmlns:LastName").text
    ep.patient_middle_name  = xmldoc.xpath("//xmlns:Patient/xmlns:Name/xmlns:MiddleName").text
    ep.patient_birthdate    = xmldoc.xpath("//xmlns:Patient/xmlns:DateOfBirth/xmlns:Date").text
    ep.patient_gender       = xmldoc.xpath("//xmlns:Patient/xmlns:Gender").text
    ep.patient_phone_number = xmldoc.xpath("//xmlns:Patient/xmlns:CommunicationNumbers/xmlns:Communication/xmlns:Number").text
    ep.patient_address      = xmldoc.xpath("//xmlns:Patient/xmlns:Address/xmlns:AddressLine1").text
    ep.patient_city         = xmldoc.xpath("//xmlns:Patient/xmlns:Address/xmlns:City").text

    ep.item_description      = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:DrugDescription").text
    ep.item_strength         = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:xxxxxxxxx").text
    ep.item_dosage_form_code = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:DrugCoded/xmlns:ProductCode").text
    ep.item_quantity         = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:Quantity/xmlns:Value").text
    ep.item_number           = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:DrugCoded/xmlns:ProductCode").text
    ep.item_subst_code       = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:Substitutions").text
    ep.item_written_date     = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:WrittenDate").text
    ep.item_reference        = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:xxxxxxxxxxx").text
    ep.item_sig1             = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:xxxxxxxxxxx").text
    ep.item_sig2             = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:xxxxxxxxxxx").text

    ep.diagnosis_code       = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:Diagnosis/xmlns:Primary/xmlns:Value").text
    ep.diagnosis_qualifier  = xmldoc.xpath("//xmlns:MedicationPrescribed/xmlns:Diagnosis/xmlns:Primary/xmlns:Qualifier").text

    ep.supervisor_last_name  = xmldoc.xpath("//xmlns:Supervisor/xmlns:Name/xmlns:LastName").text
    ep.supervisor_first_name = xmldoc.xpath("//xmlns:Supervisor/xmlns:Name/xmlns:FirstName").text
    ep.supervisor_npi_number = xmldoc.xpath("//xmlns:Supervisor/xmlns:Name/xmlns:MiddleName").text

    # answer an ep instance
    ep

  end


  def validate(schema_path)
    read_schema(schema_path)
    @schema.validate(@document)
  end

  private
    def read_schema(schema_path)
      @schema = Nokogiri::XML::Schema(File.read(schema_path))
    end

  private
  def read_document(document_path)
    @document = Nokogiri::XML(File.read(document_path))
  end

end
