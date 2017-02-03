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
    params[:item][:drug_class] = params[:item][:drug_class].to_i
    params[:item][:maintenance_code] = params[:item][:maintenance_code].to_i

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
    params[:item][:drug_class] = params[:item][:drug_class].to_i
    params[:item][:maintenance_code] = params[:item][:maintenance_code].to_i

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

      params.require(:item).permit(:company_id, :pharmacy_id, :cdb_monograph_id, :price_based_pricing_schedule, :quantity_based_pricing_schedule, :legacy_item_id_number, :item_name, :mfg_description, :ndc_number, :scanned_ndc_number, :clinical_ndc_number, :synonym, :ddid_number, :kdc_code, :generic_product_identifier, :active, :dea_schedule, :awp_unit_price, :mac_unit_price, :act_unit_price, :wac_unit_price, :govt_340b_unit_price, :contract_unit_price, :nadac_unit_price, :custom_unit_price, :awp_automatic_update, :mac_automatic_update, :act_automatic_update, :wac_automatic_update, :govt_340b_automatic_update, :contract_automatic_update, :nadac_automatic_update, :custom_automatic_update, :last_awp_update_date, :last_mac_update_date, :last_act_update_date, :last_wac_update_date, :last_340b_update_date, :last_contract_update_date, :last_nadac_update_date, :last_custom_update_date, :route_of_administration_code, :dosage_form, :inventory, :quantity_on_hand, :strength, :package_size, :package_size_unit_measure, :mfg_name, :drug_class, :item_taxable, :dispensing_unit, :state_billing_code, :alternate_product_code, :alternate_product_qualifier, :memo, :notes, :counseling_notes, :brand_generic_compound, :brand_generic_xref, :fed_tax, :unit_of_measure, :dosage_form_code, :strength_unit_measure_code, :potency_code, :maintenance_code, :doc_u_dose, :discard_age_days, :remote_dispensing, :image_file_name, :imprint_side1, :imprint_side2, :clarity, :coating, :color, :flavor, :scored, :shape, :appearance_text, :monitoring_program, :monitoring_file_name, :monograph_file_name, :medication_guide_file_name, :black_box_file_name, :contains_acetaminophen, :contains_pseudoephedrine, :label_warnings, :active_ingredient, :wellness_tracking, :retest_date, :limited_distribution, :hsa_fsa_eligible, :on_contract, :gpo_drug, :pos_item, :upc_product_number, :upc_category)
    end
end
