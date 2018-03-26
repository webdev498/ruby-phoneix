class PosTransaction < ActiveRecord::Base

  has_many :posDetails
  has_many :posPayments

  enum payment_methods: [:cash, :credit, :hsa, :other]
  before_create :getNewTicketNumber
  def self.payment_method_enum_to_string(enumvalue)
    case (enumvalue.to_i)
      when 0
        return "CSH"
      when 1
        return "CC"
      when 2
        return "HSA"
      when 3
        return "OTH"
      else
        return "OTH"
    end
  end

  def self.payment_method_string_to_enum(enumvalue)
    case (enumvalue)
      when "CSH"
        return 0
      when "CC"
        return 1
      when "HSA"
        return 2
      when "OTH"
        return 3
      else
        return 0
    end
  end

  def addNewDetail(params)
    category = PosCategory.find(params[:categoryId]) rescue nil
    if category && category.category_abbreviation == "RX"
      prescription,item,fillDetails = PosDetail.getPrescription(params[:itemId])
      newDetail = PosDetail.create({
                                       pos_transaction_id: self.id,
                                       fill_number: fillDetails.fill_number,
                                       rx_number: prescription.rx_number,
                                       item_description: item.item_name[0..19],
                                       quantity: params[:quantity].to_i,
                                       created_at: Time.now,
                                       updated_at: Time.now,
                                       item_type: "RX",
                                       item_number: item.id,
                                       medical_item: true,
                                       category: category.category_abbreviation,
                                       price: fillDetails.price.nil? ? 0.0 :  fillDetails.price * params[:quantity].to_f,
                                       tax_amount: fillDetails.tax.nil? ? 0.0 : fillDetails.tax * params[:quantity].to_f
                                   })
    else
     item = PosDetail.getItem(params[:itemId])
     newDetail = PosDetail.create({
                                      pos_transaction_id: self.id,
                                      quantity: params[:quantity].to_i,
                                      created_at: Time.now,
                                      updated_at: Time.now,
                                      item_description: item ? item.item_name[0..19] : params[:description].to_s[0..19],
                                      item_type: "OTC",
                                      item_number: item ? item.upc_product_number : nil,
                                      medical_item: params[:medical] ? (params[:medical].to_s.downcase == "y" ? true : false) : false,
                                      category: category.nil? ? "NA" : category.category_abbreviation,
                                      rx_number: nil,
                                      price: item ? item.awp_unit_price.to_f * params[:quantity].to_f : params[:each].to_f * params[:quantity].to_f,
                                      tax_amount: item ? item.fed_tax.to_f * params[:quantity].to_f : 0.0
                                  })
    end
    update_transaction_price
  end

  def deleteDetail(params)
    detailToDelete = PosDetail.find(params[:detailId]) rescue nil
    if detailToDelete
      detailToDelete.delete
    end
    update_transaction_price
  end

  def update_transaction_price
    medical_amount = 0.0
    non_medical_amount = 0.0
    medical_tax = 0.0
    non_medical_tax = 0.0

    total = 0.0
    total_tax = 0.0

    self.posDetails.each do |detail|
      next if detail.price.nil?
      if(detail.medical_item == true)
        medical_amount += detail.price
        medical_tax += detail.tax_amount.nil? ? 0.0 : detail.tax_amount
      else
        non_medical_amount += detail.price
        non_medical_tax += detail.tax_amount.nil? ? 0.0 : detail.tax_amount
      end
    end

    self.total_amount =  medical_amount + non_medical_amount
    self.total_tax = medical_tax + non_medical_tax

    self.medical_total = medical_amount + medical_tax
    self.medical_amount = medical_amount
    self.medical_tax = medical_tax

    self.non_medical_total = non_medical_amount + non_medical_tax
    self.non_medical_amount = non_medical_amount
    self.non_medical_tax = non_medical_tax

    self.updated_at = Time.now()
    self.number_items = self.posDetails.length
    self.save!
  end

  def getNewTicketNumber
    most_recent_ticket_number_transaction = PosTransaction.where.not(ticket_number: [nil]).order(ticket_number: :desc).first
    ticket_number = 1
    if most_recent_ticket_number_transaction
      ticket_number = most_recent_ticket_number_transaction.ticket_number.to_i + 1
    end
    self.ticket_number = ticket_number
  end

end
