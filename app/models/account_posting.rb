class AccountPosting < ActiveRecord::Base
   belongs_to :account

    enum post_source: [ :rx_posting, :pos_posting, :manual, :remittance ]
    enum post_type: [ :charge, :payment, :adjustment, :finance_charge, :discount ]
    scope :later_than, -> later_than_date {  where("post_date > '#{later_than_date}'") }
    # scope :payment, -> { where(post_type: payment) }
    # scope :charge, -> { where(post_type: charge) }
    # scope :adjustment, -> { where(post_type: adjustment) }
    # scope :financeCharge, -> { where(post_type: financeCharge) }
    # scope :discount, -> { where(post_type: discount) }

    def self.nextPostings(account_number,later_than_date,transaction_type = 'all',startPage = 1,pageSize = 9)
      if transaction_type == 'charge'
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).charge.page(startPage).per(pageSize)
      elsif transaction_type == 'payment'
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).payment.page(startPage).per(pageSize)
      elsif transaction_type == 'discount'
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).discount.page(startPage).per(pageSize)
      elsif transaction_type == 'adjustment'
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).adjustment.page(startPage).per(pageSize)
      elsif transaction_type == 'financeCharge'
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).financeCharge.page(startPage).per(pageSize)
      else
        AccountPosting.where({account_number: account_number}).later_than(later_than_date).page(startPage).per(pageSize)
      end
    end

    def post_type_description
      if self.post_medical_amount.to_i < 0 || self.post_non_medical_amount < 0
        "Pmt"
      else
        "Chg"
      end
    end

    def post_amount_formatted
      if self.post_medical_amount.to_i == 0
        if self.post_non_medical_amount < 0
          positiveValue = self.post_non_medical_amount * -1.0
          return ("%.2f" % positiveValue) + "-"
        else
          return ("%.2f" % self.post_non_medical_amount)
        end
      else
        if self.post_medical_amount < 0
          positiveValue = self.post_medical_amount * -1.0
          return ("%.2f" % positiveValue) + "-"
        else
          return ("%.2f" % self.post_medical_amount)
        end
      end
    end

    def is_payment
      if self.post_medical_amount.to_i == 0
        if self.post_non_medical_amount < 0
          return true
        else
          return false
        end
      else
        if self.post_medical_amount < 0
          return true
        else
          return false
        end
      end
    end

    def self.getCount(account_number,date_string,transaction_type)
      if transaction_type == 'charge'
        AccountPosting.where({account_number: account_number}).later_than(date_string).charge.count
      elsif transaction_type == 'payment'
        AccountPosting.where({account_number: account_number}).later_than(date_string).payment.count
      elsif transaction_type == 'discount'
        AccountPosting.where({account_number: account_number}).later_than(date_string).discount.count
      elsif transaction_type == 'adjustment'
        AccountPosting.where({account_number: account_number}).later_than(date_string).adjustment.count
      elsif transaction_type == 'financeCharge'
        AccountPosting.where({account_number: account_number}).later_than(date_string).financeCharge.count
      else
        AccountPosting.where({account_number: account_number}).later_than(date_string).count
      end
    end
end
