class PosDetail < ActiveRecord::Base

  belongs_to :posTransaction


  def self.getPrescription(id)
    if id.length == 9
      prescriptionId = id[0..6].to_i
      refillNumber = id[7..8].to_i
    else
      prescriptionId = id.to_i
      refillNumber = nil
    end
    prescription = Prescription.find_by(rx_number: prescriptionId)

    return nil,nil,nil if prescription.nil?

    prescription_item = Item.find(prescription.item_id)
    if(refillNumber)
      fillInfo = prescription.dispenses.find_by(fill_number: refillNumber)
    else
      fillInfo = prescription.dispenses.first
    end

    if fillInfo.nil?
      return nil,nil,nil
    else
      return prescription, prescription_item, fillInfo
    end

  end

  def self.getItem(id)
    return Item.find_by(upc_product_number: id.to_i)
  end

  def self.itemOrPrescription?(id)
    if(id.length == 7 || id.length == 9)
      return "prescription"
    else
      return "item"
    end


  end
end
