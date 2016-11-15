class Formula < ActiveRecord::Base

  belongs_to :item
  has_many :ingredients

  enum dispensing_unit: [:each, :grams, :millileters]
  enum compound_form: [ :capsule, :ointment, :cream, :suppository, :powder, :emulation, :liquid, :tablet, :Solution, :suspension, :lotion, :shampoo, :elixir, :syrup, :lozenge, :enema]
  enum level_of_effort: [ :not_specified, :under_5_minutes, :under_15_minutes, :under_30_minutes, :under_45_minutes, :hour]

  accepts_nested_attributes_for :ingredients

  after_find :get_ingredient_counts

  # Anytime we add an ingredient
  # We need to set the unit cost using the parent price basis

  def addIngredient(params)
    parent_item = self.item
    ingredient_item = Item.find(params[:ingredient][:item_id])
    create_params = {
        base_item_id: params[:ingredient][:item_id],
        quantity:  params[:ingredient][:quantity],
        basis_of_cost: parent_item.price_basis.to_i,
        formula_id: self.id,
        ndc_number: ingredient_item.ndc_number,
        base_cost: Ingredient.getPrice(
            {basis: parent_item.price_basis.to_i,
             quantity: params[:ingredient][:quantity],
             item_id: params[:ingredient][:item_id]
            })
    }
    Ingredient.create(create_params)
    set_unit_cost
  end

  # Here we review the number of
  # OTC and Legend ingredients dynamically
  # on every formula fetch

  def get_ingredient_counts
    otc = 0
    legend = 0
    self.ingredients.each do |ingredient|
      if ingredient.get_base_item.drug_class == 'legend'
        legend += 1
      elsif ingredient.get_base_item.drug_class == 'over_the_counter'
        otc += 1
      end
    end
    self.number_legend_ingredients = legend
    self.number_otc_ingredients = otc
  end

  # Here we get the total cost of all the items
  # and using the parent compound cost basis for
  # all the pricing

  def get_formula_base_cost
    price = 0.0
    self.ingredients.each do |ingredient|
      price += ingredient.getPrice * ingredient.quantity
    end
    return price
  end

  # Here we get the total cost of all the items
  # divide by the quantity the in the formula
  # and using the parent compound cost basis for
  # all the pricing - we set that price

  def set_unit_cost
    cost_per_unit = 0.0
    if(self.quantity_produced.to_i > 0)
      cost_per_unit = (get_formula_base_cost/self.quantity_produced.to_f)
    end
    set_parent_item_base_cost(cost_per_unit)
  end

  # When calculating a cost we use the cost basis of the PARENT
  # compound/item to calculate the individual ingredient prices
  # This method supports that
  def set_parent_item_base_cost(new_unit_price)

    price = 0.0
    case (self.item.price_basis.to_i)
      when 0#[:awp]
        self.item.awp_unit_price = new_unit_price
      when 1 #[:act]
        self.item.act_unit_price = new_unit_price
      when 2 #[:basis_340b]
        self.item.govt_340b_unit_price = new_unit_price
      when 3 #[:wac]
        self.item.wac_unit_price = new_unit_price
      when 4 #[:contract]
        self.item.contract_unit_price = new_unit_price
      when 5 #[:nadac]
        self.item.nadac_unit_price = new_unit_price
      when 6 #[:custom]
        self.item.custom_unit_price = new_unit_price
      when 7 #[:user]
        self.item.mac_unit_price = new_unit_price
      else
        price = 0.0
    end
    self.item.save!
  end

end
