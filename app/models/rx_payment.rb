class RxPayment < ActiveRecord::Base

  belongs_to :dispenses

  enum posted: [ :not_posted, :posted_to_artx, :posted_to_ar ]

  def self.payment_from_dispense dispense
    payment = self.new

    payment.company_id  = dispense.company_id
    payment.pharmacy_id = dispense.pharmacy_id
    payment.dispense_id = dispense.id
    payment.rx_number   = dispense.rx_number
    payment.fill_number = dispense.fill_number
    payment.payor_sequence = 1  # set sequence to 1 for now
    payment.plan_id_code = 0    # cash payments for now !!!
    payment.amount_paid = dispense.price
    payment.posted = "not_posted"
    payment.billed = 0
    payment
  end

end
