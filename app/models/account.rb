class Account < ActiveRecord::Base

	has_many :accountPosting

	enum account_method: [ :balanceForward, :openItem ]
	enum payor_type: [:patient, :headOfHousehold, :sponsor, :master, :plan, :facility]
	enum rx_charge_description: [:drug, :customer, :drugAndPatient, :quantityAndDrug]
	enum statement_type: [:laser, :paperForm, :email]

	attr_accessor :display_name

  after_find :set_display_name


  # def set_display_name
	# 	self.display_name = self.last_name + ", " + self.first_name
	# end

	# def customer_full_name
	#     return self.first_name.to_s + " " + self.last_name.to_s
	#   end

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

end
