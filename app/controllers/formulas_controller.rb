class FormulasController < ApplicationController
  before_action :set_formula, only: [:show, :edit, :update, :destroy]

  # GET /formulas
  # GET /formulas.json
  def index
    @formulas = Formula.all
  end

  # GET /formulas/1
  # GET /formulas/1.json
  def show
    respond_to do |format|
        format.html
        format.json { render json: @formula}
    end

  end

  # GET /formulas/new
  def new
    @formula = Formula.new
  end

  # GET /formulas/1/edit
  def edit
  end

  # POST /formulas/addIngredient
  # { compound_id: ? ,
  #    ingredient: {
  #      basis_of_cost: one of ["AWS","...","".....],
  #      quantity: 1
  #      base_item_id: 343 - The item id of the ingredient
  #    }
  # }

  # compounding
  def removeIngredient
    ingredient = Ingredient.find( params[:id] )

    ingredient.destroy!
    formula = ingredient.formula
    @item = formula.item
    @ingredients = formula.ingredients
    formula.set_unit_cost
    render template: 'formulas/js/ingredient_delete.js'
  end

  # When updating an ingredient we need get the cost basis on the compound itself and use
  # that value for all calculations

  def updateIngredient
    @ingredient = Ingredient.find(params[:id])
    @formula = @ingredient.formula
    @item = @formula.item
    @ingredient.quantity = params[:newQuantity] if params[:newQuantity]
    if params[:base_item_id]
      ingredient_item = Item.find(params[:base_item_id])
      @ingredient.base_item_id = params[:base_item_id]
      @ingredient.ndc_number = ingredient_item.ndc_number
      @ingredient.base_cost = Ingredient.getPrice(
          {basis: @item.cost_basis.to_i,
           quantity: @ingredient.quantity,
           item_id: params[:base_item_id]
          })
    end
    @ingredient.save!
    @formula.set_unit_cost
    @ingredients = @formula.reload.ingredients
      render partial: "/formulas/ingredients_table"
  end

  def addIngredient
    @item = Item.find(params[:compound_id])
    @formula = @item.formula
    if @formula.nil?
      @formula.create({:item_id => @item.id})
    end
    @formula.addIngredient(params)
    @formula.set_unit_cost
    @ingredients = @formula.ingredients
    render partial: "/formulas/ingredients_table"
  end

  def ingredients
    @item = Item.find(params[:id])
    if(@item.formula)
      @ingredients = @item.formula.ingredients
    else
      @ingredients = []
    end

    render :partial => '/formulas/ingredients_table'
  end

  # POST /formulas
  # POST /formulas.json
  def create

    params[:formula][:compound_form] = params[:formula][:compound_form].to_i
    params[:formula][:dispensing_unit] = params[:formula][:dispensing_unit].to_i
    params[:formula][:level_of_effort] = params[:formula][:level_of_effort].to_i
    @formula = Formula.new(formula_params)

    respond_to do |format|
      if @formula.save
        format.html { redirect_to @formula, notice: 'Formula was successfully created.' }
        format.json { render :show, status: :created, location: @formula }
      else
        format.html { render :new }
        format.json { render json: @formula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formulas/1
  # PATCH/PUT /formulas/1.json
  def update
    params[:formula][:compound_form] = params[:formula][:compound_form].to_i
    params[:formula][:dispensing_unit] = params[:formula][:dispensing_unit].to_i
    params[:formula][:level_of_effort] = params[:formula][:level_of_effort].to_i
    params[:formula][:quantity_produced] = params[:formula][:quantity_produced].to_i
    respond_to do |format|
      if @formula.update(formula_params)
        @formula.set_unit_cost
        format.html { redirect_to @formula, notice: 'Formula was successfully updated.' }
        format.json { render json: {status: :ok} }
      else
        format.html { render :edit }
        format.json { render json: @formula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulas/1
  # DELETE /formulas/1.json
  def destroy
    @formula.destroy
    respond_to do |format|
      format.html { redirect_to formulas_url, notice: 'Formula was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formula
      @formula = Formula.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formula_params
      params.require(:formula).permit(:company_id, :pharmacy_id, :item_id, :legacy_item_id_number, :compound_form, :dispensing_unit, :route_of_administration, :total_acquisition_cost, :total_base_cost, :quantity_produced, :number_legend_ingredients, :number_otc_ingredients, :level_of_effort_code, :instructions, :flavor)
    end
end
