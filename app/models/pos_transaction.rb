class PosTransaction < ActiveRecord::Base

  has_many :posDetails
  
  def addNewDetail(params)
    if(PosDetail.itemOrPrescription?(params[:itemId]) == "prescription")
      prescription,item,fillDetails = PosDetail.getPrescription(params[:itemId])
      newDetail = PosDetail.create({
                                       pos_transaction_id: self.id,
                                       fill_number: fillDetails.number,
                                       rx_number: prescription.number,
                                       quantity: params[:quantity],
                                       created_at: Time.now,
                                       updated_at: Time.now,
                                       item_type: "RX",
                                       medical_item: true,
                                       price: fillDetails.price,
                                       tax_amount: fillDetails.tax
                                   })
    else
     item = PosDetail.getItem(params[:itemId])
     newDetail = PosDetail.create({
                                      pos_transaction_id: self.id,
                                      quantity: params[:quantity],
                                      created_at: Time.now,
                                      updated_at: Time.now,
                                      item_type: "OTC",
                                      price: item.awp_unit_price * params[:quantity].to_f,
                                      tax_amount: item.fed_tax * params[:quantity].to_f
                                  })
    end
    update_transaction_price

  end

  def update_transaction_price

  end

end
