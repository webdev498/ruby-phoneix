class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # price check form
  def new_priceCheck
	@item = Item.new
	render 'price_check'
  end


  # do the price check, answer the results
  def priceCheck
	@item = Item.find params[:item_id]
	render 'price_check'
  end


  #  ajax answer the next page for paginated Item search
  def nextItems
    @searchItems = Item.nextItems params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchItems.js'
  end

  def nextCompoundItems
    brand_generic_compound  = params[:brand_generic_compound].to_i ? params[:brand_generic_compound] : 0
    brand_generic_xref  = params[:brand_generic_xref_d] ? params[:brand_generic_xref_d] : ''
    pageNumber = params[:page] ? params[:page] : 1
    perPage = 9

    brand_generic_compound = 0 if brand_generic_compound == 1
    brand_generic_compound = 1 if brand_generic_compound == 0

    if brand_generic_compound == '2'
      @searchItems = Item.search_arel(brand_generic_xref).page(pageNumber).per(perPage)
    else
      @searchItems = Item.search_arel(brand_generic_xref).where("brand_generic_compound=#{brand_generic_compound}").page(pageNumber).per(perPage)
    end
    render  template: 'common/search/js/nextSearchCompoundItems.js'
  end

  #  ajax answer the next page for paginated Ingredient search for a compound
  def nextIngredients
    @searchItems = Item.nextItems params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchIngredients.js'
  end

  # we are using a seperate erb file since we are triggering a different event at the
  # end
  # To Do : Look to dry this up a little maybe?
  def nextExistingIngredients
    @currentIngredientId = params[:ingredient_id]
    @searchItems = Item.nextItems params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchExistingIngredients.js.erb'
  end

  # Here are looking to return items that are ONLY compounds since only
  # compounds have a formula
  # we are using a seperate erb file since we are triggering a different event at the
  # end
  # To Do : Look to dry this up a little maybe?

  def nextItemFormulaToCopy
    @searchItems = Item.nextCompounds params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchItemFormulaToCopy.js.erb'
  end

  # compounding
  def addCompound
    @item = Item.find( params[:id] )
    render 'item'
  end

  def clinicalInquiry
      @item = Item.new
      render "clinical_drug"
  end

  # testing with default item #35
  def item
    @item = Item.find(params[:id])
  end

  # this is temporary
  def show_item
    @item = Item.find( params[:id] )
    render 'item'
  end

    # testing with page 2
	def get_more_items
    @items = Item.page(2)
	end


  # GET /items
  # GET /items.json
  def index
    @item = Item.new
    #@items = Item.all
    #redirect_to :controller => 'searches', :action => 'new', :searching_for => 'item'
  end

  # GET /items/1
  # GET /items/1.json
  def show
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @item }
    end
  end

  def copyFormula
    @item = Item.find(params[:target_item_id])
    @item.copyFormulaFromExistingItem(params[:formula_id])

    render :html => "Success"
  end

  # get one prescription via the rx number
  def show_rx_prescription
    @item = Item.find_by_rx_number( params[:rx_number] )
    render "prescription"
  end


  # GET /items/new
  def new
    @item = Item.new
#testing
#    @item = Item.find(2048)
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create

    # params enums to integer
    params[:item][:brand_generic_compound] = params[:item][:brand_generic_compound].to_i
    params[:item][:dea_schedule] = params[:item][:dea_schedule].to_i

    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    params[:item][:item_name] = params[:item][:item_name].upcase

    # params enums to integer
    params[:item][:brand_generic_compound] = params[:item][:brand_generic_compound].to_i
    params[:item][:dea_schedule] = params[:item][:dea_schedule].to_i

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    # @item.destroy
    # respond_to do |format|
    #   format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end




  # items/ingredientDetails/1234

  def ingredient_details
    @parent_item = Item.find(params[:compound_id])
    @item = Item.find(params[:id])
    render :partial => '/items/ingredient_details'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
#      params.require(:item).permit(:dept_number, :rna_item_id_number, :item_name, :ndc_number, :scanned_ndc_number, :gcnseq_number, :synonym, :active_flag, :dea_schedule, :awp_unit_price, :mac_unit_price, :act_unit_price, :wac_unit_price, :govt_340b_unit_price, :custom_unit_price, :awp_automatic_update, :mac_automatic_update, :act_automatic_update, :wac_automatic_update, :govt_340b_automatic_update, :custom_automatic_update, :last_price_update_date, :schedule_number, :quantity_schedule_number, :inventory, :quantity_on_hand, :strength, :package_size, :drug_class, :item_taxable, :dispensing_unit, :state_billing_code, :alternate_product_code, :alternate_product_qualifier, :item_hcpcs_code, :procedure_code, :procedure_modifier1, :procedure_modifier2, :counseling_code1, :counseling_code2, :counseling_code3, :memo, :brand_generic_compound, :brand_generic_xref, :fed_tax, :unit_of_measure, :erx_unit_of_measure, :discard_age, :remote_dispensing, :image_file_name, :imprint_side1, :imprint_side2, :shape, :color, :image_description)
params.require(:item).permit(:legacy_item_id_number, :item_name, :ndc_number, :scanned_ndc_number, :synonym, :active, :dea_schedule, :awp_unit_price, :mac_unit_price, :act_unit_price, :wac_unit_price, :govt_340b_unit_price, :contract_unit_price, :nadac_unit_price, :custom_unit_price, :awp_automatic_update, :mac_automatic_update, :act_automatic_update, :wac_automatic_update, :govt_340b_automatic_update, :contract_automatic_update, :nadac_automatic_update, :custom_automatic_update, :last_price_update_date, :schedule_number, :quantity_schedule_number, :inventory, :quantity_on_hand, :strength, :package_size, :drug_class, :item_taxable, :dispensing_unit, :state_billing_code, :alternate_product_code, :alternate_product_qualifier, :item_hcpcs_code, :procedure_code, :procedure_modifier1, :procedure_modifier2, :counseling_code, :memo, :brand_generic_compound, :brand_generic_xref, :fed_tax, :unit_of_measure, :dosage_form_code, :strength_code, :discard_age, :remote_dispensing, :image_file_name, :imprint_side1, :imprint_side2, :clarity, :coating, :color, :flavor, :scored, :shape, :appearance_text, :monitoring_program, :monitoring_file_name, :on_contract, :gpo_drug, :pos_item, :upc_product_number, :upc_category)
    end
end
