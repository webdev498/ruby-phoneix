class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.all
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
    respond_to do |format|
      format.html { redirect_to @ingredient }
      format.json { render json: @ingredient }
    end
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # GET /ingredients/price?item_id=1&quantity=8&basis=1
  def price
    cost = Ingredient.getPrice(params)
    render json: {price: "%.2f" % cost }
  end

  # POST /ingredients
  # POST /ingredients.json
  def create

    ingredient_params[:formula][:basis_of_cost] = ingredient_params[:formula][:basis_of_cost].to_i

    params[:ingredient][:basis_of_cost] = Ingredient.cost_basis_options.find_index(params[:ingredient][:basis_of_cost])
    @ingredient = Ingredient.new(params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    ingredient_params[:formula][:basis_of_cost] = ingredient_params[:formula][:basis_of_cost].to_i

    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { render :json, @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:company_id, :pharmacy_id, :formula_id, :item_id, :base_item_id, :legacy_item_id_number, :ndc_number, :basis_of_cost, :base_cost, :acquisition_cost, :quantity, :alternate_product_type, :alternate_product_code, :waste_factor)
    end
end
