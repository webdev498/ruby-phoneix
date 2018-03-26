class Account < ActiveRecord::Base

	has_many :accountPosting

	enum accounting_method: [ :balance_forward, :open_item ]
	enum payor_type: [:patient, :head_of_household, :sponsor, :master, :plan, :facility]
	enum rx_charge_description: [:drug, :customer, :drug_and_patient, :quantity_and_drug]
	enum statement_type: [:laser, :paper_form, :email]
        enum print_statement: [:print, :no_statement, :send_email]

	attr_accessor :display_name

  after_find :set_display_name


	  def set_display_name
			customer = Customer.find_by_account_number(self.account_number)
			self.display_name = customer.last_name + ", " + customer.first_name
		end

		def customer_full_name
			customer = Customer.find_by_account_number(self.account_number)
			return customer.first_name.to_s + " " + customer.last_name.to_s
	  end

	  def balance
	    self.current_period_amount.to_f + self.last_period_amount.to_f  + self.over_30_amount.to_f  + self.over_60_amount.to_f  + self.over_90_amount.to_f
	  end

		def postings_since(date_string = nil, transaction_type = 'all', startPage = 1, pageSize = 9)
			date_string ||= self.last_statement_date
			return AccountPosting.nextPostings(self.account_number,date_string,transaction_type,startPage,pageSize)
		end

		def allPostings
			return AccountPosting.where({account_number: self.account_number})
		end

		def total_posting_count_since(date_string = nil,transaction_type = 'all')
	    date_string ||= self.last_statement_date
	    AccountPosting.getCount(self.account_number,date_string,transaction_type)

		end

		def self.search_by_name sourceString
			customers = Customer.search_by_name sourceString
		end

		def self.next_account	searchFor, startPage=1, pageSize=9
			Customer.nextCustomersWithAccount searchFor, startPage, pageSize
		end

end
