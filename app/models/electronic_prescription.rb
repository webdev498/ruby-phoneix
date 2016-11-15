class ElectronicPrescription < ActiveRecord::Base


  scope :by_customer_name, -> sourceString { where( "UPPER(received_customer_name) like '%#{sourceString}%'" ) }
  scope :by_prescriber_name, -> sourceString { where( "UPPER(received_prescriber_name) like '%#{sourceString}%'" ) }
  scope :by_item_name, -> sourceString { where( "UPPER(received_item_name) like '%#{sourceString}%'" ) }


  attr_accessor :prescriber_last_name
  attr_accessor :prescriber_first_name
  attr_accessor :prescriber_middle_name
  attr_accessor :clinic_city
  attr_accessor :patient_last_name
  attr_accessor :patient_first_name
  attr_accessor :patient_middle_name
  attr_accessor :patient_city
  attr_accessor :item_description
  attr_accessor :item_strength
  attr_accessor :item_dosage_form_code
  attr_accessor :item_sig1
  attr_accessor :item_sig2
  attr_accessor :supervisor_last_name

  attr_accessor :patient_matched
  attr_accessor :prescriber_matched
  attr_accessor :item_matched

  attr_accessor :prescriber_npi_number
  attr_accessor :prescriber_phone_number

  attr_accessor :patient_birthdate
  attr_accessor :patient_gender
  attr_accessor :patient_phone_number
  attr_accessor :patient_address
  attr_accessor :patient_city

  attr_accessor :item_quantity
  attr_accessor :item_number
  attr_accessor :item_subst_code
  attr_accessor :item_written_date
  attr_accessor :item_reference

  attr_accessor :diagnosis_code
  attr_accessor :diagnosis_qualifier

  attr_accessor :supervisor_first_name
  attr_accessor :supervisor_npi_number


  def self.paged_search_by_partial_customer sourceString, pageNumber, perPage
		ElectronicPrescription.by_customer_name(sourceString.upcase).page(pageNumber).per(perPage)
	end

  def self.nextElectronicPrescriptionsByCustomer searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial_customer searchItem, startPage, pageSize
      else
          self.paged_search_by_partial_customer searchItem, 1, pageSize
      end
  end

  def self.paged_search_by_partial_prescriber sourceString, pageNumber, perPage
		ElectronicPrescription.by_prescriber_name(sourceString.upcase).page(pageNumber).per(perPage)
	end

  def self.nextElectronicPrescriptionsByPrescriber searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial_prescriber searchItem, startPage, pageSize
      else
          self.paged_search_by_partial_prescriber searchItem, 1, pageSize
      end
  end

  def self.paged_search_by_partial_item sourceString, pageNumber, perPage
		ElectronicPrescription.by_item_name(sourceString.upcase).page(pageNumber).per(perPage)
	end

  def self.nextElectronicPrescriptionsByItem searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial_item searchItem, startPage, pageSize
      else
          self.paged_search_by_partial_item searchItem, 1, pageSize
      end
  end


end
