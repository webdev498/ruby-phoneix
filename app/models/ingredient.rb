class Ingredient < ActiveRecord::Base

	belongs_to :formula
	belongs_to :item, class_name: "Item", foreign_key: "item_id"
#	belongs_to :ingredient_item, class_name: 'Item'

	enum basis_of_cost: [ :awp, :act, :mac , :basis_340b, :wac, :contract, :nadac, :custom, :user]
  enum brand_generic_compound: [ :brand, :generic, :compound ]
	accepts_nested_attributes_for :item

  # Every ingredient is based on an existing item
  # the belongs to is not quite right so we are using a reference through the base_item_id
  def get_base_item
    Item.find(self.base_item_id)
  end

  # When getting the price of an ingredient we need to use the basis of the formula's compound
  # not that of the ingredient item
  def getPrice

    item = self.formula.item.price_basis
    price = 0.0
    case (item.price_basis.to_i)
      when 0#[:awp]
        price = item.awp_unit_price
      when 1 #[:act]
        price = item.act_unit_price
      when 2 #[:basis_340b]
        price = item.govt_340b_unit_price
      when 3 #[:wac]
        price = item.wac_unit_price
      when 4 #[:contract]
        price = item.contract_unit_price
      when 5 #[:nadac]
        price = item.nadac_unit_price
      when 6 #[:custom]
        price = item.custom_unit_price
      when 7 #[:user]
        price = item.mac_unit_price
      else
        price = 0.0
    end
    price
  end

  # This method allows us to pass a cost basis manually and look
  # up the price of the item
  # We can either specify the item OR the ingredient id to find the item
  def self.getPrice(params)
    item = nil
    ingredient = nil
    if params[:item_id]
      item = item = Item.find(params[:item_id])
    else
      ingredient = Ingredient.find(params[:ingredient_id])
      item = ingredient.get_base_item
    end

    price = 0.0

    case (params[:basis].to_i)
      when 0#[:awp]
        price = item.awp_unit_price
      when 1 #[:act]
        price = item.act_unit_price
      when 2 #[:basis_340b]
        price = item.govt_340b_unit_price
      when 3 #[:wac]
        price = item.wac_unit_price
      when 4 #[:contract]
        price = item.contract_unit_price
      when 5 #[:nadac]
        price = item.nadac_unit_price
      when 6 #[:custom]
        price = item.custom_unit_price
      when 7 #[:user]
        price = item.mac_unit_price
      else
        price = 0.0
    end
    newprice = price.to_f * params[:quantity].to_f
    if ingredient
      ingredient.base_cost = newprice
      ingredient.save
    end
    newprice
  end

  def name
    name = Item.find(self.base_item_id).item_name rescue "Unknown"
    return name
  end
end
