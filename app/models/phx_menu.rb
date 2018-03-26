class PhxMenu

	include ActiveModel::Model
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations
	include ActiveModel::Conversion
	include ActiveModel::Naming
	include Rails.application.routes.url_helpers

	cattr_accessor :phx_menus
	cattr_accessor :phx_main_menu_resources
	cattr_accessor :phx_main_menus
	cattr_accessor :phx_sub_menus
	cattr_accessor :phx_sub_menu_resources

	attr_accessor :name, :type, :menu_text, :path

	def initialize ( name, type, menu_text, path )
		@name = name
		@type = type
		@menu_text = menu_text
		@path = path
	end


	def persisted?
		false
	end


	# Class methods

	def self.setup_menus
		Rails.application.reload_routes!
		rails_routes = Rails.application.routes.url_helpers

	 	{ m_prescription: [
#				PhxMenuItem.new(:s_prescription_change, :submenu,  "Prescription Change", "", ""),
				PhxMenuItem.new(:s_prescription_electronicRx, :submenu,  "Electronic Rx", "", ""),
				PhxMenuItem.new(:s_prescription_change, :submenu,  "Change Prescription", rails_routes.findPrescription_path, rails_routes.findPrescription_path),
				PhxMenuItem.new(:s_prescription_changeDispense, :submenu,  "Change Dispense", rails_routes.findDispense_path, rails_routes.findDispense_path),
				PhxMenuItem.new(:s_prescription_priceCheck, :submenu,  "Price Check", "", ""),
				PhxMenuItem.new(:s_prescription_workflowMaintenance, :submenu,  "Workflow Maintenance", "", ""),
				PhxMenuItem.new(:s_prescription_prescriptionQueue, :submenu,  "Prescription Queue", "", ""),
				PhxMenuItem.new(:s_prescription_verification, :submenu,  "Rx Verification", rails_routes.new_rxVerification_path, rails_routes.new_rxVerification_path),
				PhxMenuItem.new(:s_prescription_rphReview, :submenu,  "Pharmacist Rx Review", "", ""),
				PhxMenuItem.new(:s_prescription_sigCodeMaintenance, :submenu,  "Sig Code Maintenance",  rails_routes.sigCode_path, rails_routes.sigCode_path),
				PhxMenuItem.new(:s_prescription_transferPrescription, :submenu,  "Transfer Prescription", "", ""),
				PhxMenuItem.new(:s_prescription_scanPrescription, :submenu,  "Scan Prescription", rails_routes.menu_prescription_path, rails_routes.menu_prescription_path),
				PhxMenuItem.new(:s_prescription_docUdoseMatenance, :submenu,  "Doc-U-Dose Maintenance", "", ""),
				PhxMenuItem.new(:s_prescription_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_prescription_prescriptionLog, :submenu,  "- Print Prescription log", "", ""),
				PhxMenuItem.new(:s_prescription_priceModeling, :submenu,  "- Price Modeling", "", ""),
				PhxMenuItem.new(:s_prescription_prescriptionRanking, :submenu,  "- Prescription Ranking", "", "") ],
		m_claim: [
				PhxMenuItem.new(:s_claim_eligibilityCheck, :submenu,  "Eligbility Check", "", ""),
				PhxMenuItem.new(:s_claim_errorCodeMaintenance, :submenu,  "Error Code Maintenance", "", ""),
				PhxMenuItem.new(:s_claim_purgeClaims, :submenu,  "Purge Claims", "", ""),
				PhxMenuItem.new(:s_claim_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_claim_claimReport, :submenu,  "- Claim Report", "", "") ],
		m_customer: [
				PhxMenuItem.new(:s_customer_wellness, :submenu,  "Customer Wellness"),
				PhxMenuItem.new(:s_customer_remoteAccess, :submenu,  "Customer Remote Access"),
				PhxMenuItem.new(:s_customer_reports, :submenu,  "Reports:"),
				PhxMenuItem.new(:s_customer_rxSummaryReport, :submenu,  "- Rx Summary Report"),
				PhxMenuItem.new(:s_customer_profileReport, :submenu,  "- Patient Profile Report"),
				PhxMenuItem.new(:s_customer_mailingLabels, :submenu,  "- Print Mailing Labels") ],
		m_item: [
				PhxMenuItem.new(:s_item_priceScheduleMaintenance, :submenu,  "Price Schedule Maintenance", rails_routes.new_price_schedule_path,rails_routes.new_price_schedule_path),
				PhxMenuItem.new(:s_item_clinicalDrugInquiry, :submenu,  "Clinical Drug Inquiry", rails_routes.clinicalInquiry_path, rails_routes.clinicalInquiry_path),
				PhxMenuItem.new(:s_item_priceUpdates, :submenu,  "Price Updates", "", ""),
				PhxMenuItem.new(:s_item_clinicalUpdates, :submenu,  "Clinical Updates", "", ""),
				PhxMenuItem.new(:s_item_counselingCodeMaintenance, :submenu,  "Counseling Code Maintenance", "", ""),
				PhxMenuItem.new(:s_item_inventoryFunctions, :submenu,  "Inventory Functions", "", ""),
				PhxMenuItem.new(:s_item_purchaseOrders, :submenu,  "Purchase Orders", "", ""),
				PhxMenuItem.new(:s_item_vendorMaintenance, :submenu,  "Vendor Maintenance", rails_routes.new_vendor_path, rails_routes.new_vendor_path),
				PhxMenuItem.new(:s_item_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_item_drugUtilizationReports, :submenu,  "- Drug Utilization Reports", "", ""),
				PhxMenuItem.new(:s_item_printDrugMonographs, :submenu,  "- Print Drug Monographs", "", ""),
				PhxMenuItem.new(:s_item_medicationGuides, :submenu,  "- Print Medication Guides", "", "") ],
		m_prescriber: [
				PhxMenuItem.new(:s_prescriber_erxMaintenance, :submenu,  "ERx Maintenance"),
				PhxMenuItem.new(:s_prescriber_remoteAcces, :submenu,  "Prescriber Remote Access"),
				PhxMenuItem.new(:s_prescriber_sigMaintenance, :submenu,  "Prescriber Sig Code Maintenance"),
				PhxMenuItem.new(:s_prescriber_supervisingPrescriber, :submenu,  "Supervising Prescriber", rails_routes.new_prescriberSupervisors_path, rails_routes.new_prescriberSupervisors_path),
				PhxMenuItem.new(:s_prescriber_reports, :submenu,  "Reports:"),
				PhxMenuItem.new(:s_prescriber_mailingLabels, :submenu,  "- Mailing Labels"),
				PhxMenuItem.new(:s_prescriber_rxSummaryReport, :submenu,  "- Rx Summary"),
				PhxMenuItem.new(:s_prescriber_DEAreport, :submenu,  "- DEA Report") ],
		m_3rdParty: [
				PhxMenuItem.new(:s_3rdParty_BillingFile, :submenu,  "Create Billing File", "", ""),
				PhxMenuItem.new(:s_3rdParty_formularyMaintenance, :submenu,  "Formulary Maintenance", "", ""),
				PhxMenuItem.new(:s_3rdParty_planUtilization, :submenu,  "Plan Initialization", "", ""),
				PhxMenuItem.new(:s_3rdParty_claimReconcilliation, :submenu,  "Claim Reconciliation", "", ""),
				PhxMenuItem.new(:s_3rdParty_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_3rdParty_printBillingReport, :submenu,  "- Print Billing Report", "", ""),
				PhxMenuItem.new(:s_3rdParty_billingForms, :submenu,  "- Print Third Party Forms", "", ""),
				PhxMenuItem.new(:s_3rdParty_1500form, :submenu,  "- Print 1500 Form", "", "") ],
		m_pharmacy: [
#				PhxMenuItem.new(:s_pharmacy_departmentMaintenance, :submenu,  "Department Maintenance", rails_routes.pharmacy_path, rails_routes.pharmacy_path),
				PhxMenuItem.new(:s_pharmacy_employeeMaintenance, :submenu,  "Employee Maintenance", rails_routes.new_employee_path, rails_routes.new_employee_path),
				PhxMenuItem.new(:s_pharmacy_userMaintenance, :submenu,  "User Maintenance", rails_routes.userAccount_path, rails_routes.userAccount_path),
				PhxMenuItem.new(:s_pharmacy_systemBackup, :submenu,  "System Backup"),
				PhxMenuItem.new(:s_pharmacy_parameterMaintenance, :submenu,  "Parameter Maintenance", rails_routes.parameterMaintenance_path, rails_routes.parameterMaintenance_path),
				PhxMenuItem.new(:s_pharmacy_polling, :submenu,  "Polling"),
				PhxMenuItem.new(:s_pharmacy_fax, :submenu,  "Faxing"),
				PhxMenuItem.new(:s_pharmacy_security, :submenu,  "Security Functions", "", "") ],
		m_pos: [
				PhxMenuItem.new(:s_pos_ticketMaintenance, :submenu,  "POS Ticket Maintenance", "", ""),
				PhxMenuItem.new(:s_pos_signatureCapture, :submenu,  "Signature Capture", "", ""),
				PhxMenuItem.new(:s_pos_categoryMaintenance, :submenu,  "Category Maintenance", "", ""),
				PhxMenuItem.new(:s_pos_upcItemMaintenance, :submenu,  "UPC Item Maintenance", "", ""),
				PhxMenuItem.new(:s_pos_paymentMethods, :submenu,  "Methods of Payment", "", ""),
				PhxMenuItem.new(:s_pos_taxCodeMaintenance, :submenu,  "Tax Code Maintenance", "", ""),
				PhxMenuItem.new(:s_pos_reports, :submenu,  "Reports", "", ""),
				PhxMenuItem.new(:s_pos_reconcilliationReport, :submenu,  "- POS Reconciliation Report", "", ""),
				PhxMenuItem.new(:s_pos_salesReport, :submenu,  "- POS Sales Report", "", "") ],
		m_facility: [
#				PhxMenuItem.new(:s_facility_roomDefinition, :submenu,  "Room Definition", rails_routes.facility_path, rails_routes.facility_path),
#				PhxMenuItem.new(:s_facility_passTimeMaintenance, :submenu,  "Pass Time Maintenance", rails_routes.facility_path, rails_routes.facility_path),
				PhxMenuItem.new(:s_facility_orderCodeMaintenance, :submenu,  "Order Code Maintenance", "", ""),
				PhxMenuItem.new(:s_facility_changeRxStatus, :submenu,  "Change Rx Status", "", ""),
				PhxMenuItem.new(:s_facility_customOrderMaintenance, :submenu,  "Customer Order Maintenance", "", ""),
				PhxMenuItem.new(:s_facility_sortRxForPlanLimit, :submenu,  "Sort Rx for Plan Limit", "", ""),
				PhxMenuItem.new(:s_facility_returns, :submenu,  "Process Returns", "", ""),
				PhxMenuItem.new(:s_facility_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_facility_printMedicalRecords, :submenu,  "- Print Medical Records", "", ""),
				PhxMenuItem.new(:s_facility_printSpooledLabels, :submenu,  "- Print Spooled Labels", "", ""),
				PhxMenuItem.new(:s_facility_printDeliveryReceipts, :submenu,  "- Print Delivery Receipts", "", ""),
				PhxMenuItem.new(:s_facility_census, :submenu,  "- Print Home Census", "", ""),
				PhxMenuItem.new(:s_facility_homeDefinition, :submenu,  "- Print Home Definition", "", "") ],
		m_receivables: [
#				PhxMenuItem.new(:s_receivables_accountTransactionInquiry, :submenu,  "Account Transaction Inquiry", rails_routes.finance_path, rails_routes.finance_path),
				PhxMenuItem.new(:s_receivables_rxPosting, :submenu,  "Prescription Posting", "", ""),
				PhxMenuItem.new(:s_receivables_manualPosting, :submenu,  "Manual Posting", "", ""),
				PhxMenuItem.new(:s_receivables_posPosting, :submenu,  "POS Posting", "", ""),
				PhxMenuItem.new(:s_receivables_transactionFilePosting, :submenu,  "Transaction File Posting", "", ""),
				PhxMenuItem.new(:s_receivables_editTransactionFile, :submenu,  "Edit Transaction File", "", ""),
				PhxMenuItem.new(:s_receivables_accountMaintenance, :submenu,  "Account Maintenance", "", ""),
				PhxMenuItem.new(:s_receivables_changeAccountPayor, :submenu,  "Change an Account Payor", "", ""),
				PhxMenuItem.new(:s_receivables_endOfPeriod, :submenu,  "End of Period", "", ""),
				PhxMenuItem.new(:s_receivables_reports, :submenu,  "Reports:", "", ""),
				PhxMenuItem.new(:s_receivables_printTransactionFile, :submenu,  "- Print Transaction File", "", ""),
				PhxMenuItem.new(:s_receivables_printStatements, :submenu,  "- Print Statements", "", ""),
				PhxMenuItem.new(:s_receivables_agedReceivablesReport, :submenu,  "- Print Aged Receivables Report", "", ""),
				PhxMenuItem.new(:s_receivables_pastDueNotices, :submenu,  "- Past Due Notices", "", ""),
				PhxMenuItem.new(:s_receivables_accountHistory, :submenu,  "- Print Account History", "", ""),
				PhxMenuItem.new(:s_receivables_agedTrialBalance, :submenu,  "- Print Trial Balance", "", "") ],
		}
	end



	@@phx_menus ||= self.setup_menus

	# need to convert keys in phx_menus for map below
	@@phx_main_menus = {
      m_prescription:   'phx_subnav_prescription',
      m_claim:          'phx_subnav_claim',
      m_customer:       'phx_subnav_customer',
      m_item:           'phx_subnav_item',
      m_prescriber:     'phx_subnav_prescriber',
      m_3rdParty:       'phx_subnav_third_party_plan',
      m_pharmacy:       'phx_subnav_pharmacy',
      m_pos: 			'phx_subnav_point_of_sale',
      m_facility:       'phx_subnav_facility',
      m_receivables:    'phx_subnav_accounts_receivable' }


	def self.main_menu
		@@phx_menu.keys
	end


	def self.main_menu_resources
		@@phx_main_menu_resources =
			self.main_menu.each { | m |
				r = PhxResource.new( m, 1 )
			}
	end


end
