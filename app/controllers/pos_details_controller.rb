class PosDetailsController < ApplicationController
  before_action :set_pos_detail, only: [:show, :edit, :update, :destroy]

  # GET /pos_details
  # GET /pos_details.json
  def index
    @pos_details = PosDetail.all
  end

  # GET /pos_details/1
  # GET /pos_details/1.json
  def show
  end

  # GET /pos_details/new
  def new
    @pos_detail = PosDetail.new
  end

  def get_rx_or_item
    @prescription = nil
    @selectedItem = params[:categoryId]
    category = PosCategory.find(@selectedItem) rescue nil
    if category && category.category_abbreviation == "RX"
      @isMedical = "Y"
      @prescription,@item,@fillInfo = PosDetail.getPrescription(params[:id])
      if @prescription.nil?
        render status: 400
      else
        @quantity = params[:quantity]
        render layout: false, partial: "prescription_detail"
      end
    else
      @isMedical = "N"
      @item = PosDetail.getItem(params[:id])
      if(@item.nil?)
          render status: 400
      else
        @quantity = params[:quantity]
        @totalPrice = @quantity.to_f * @item.awp_unit_price.to_f
        render layout: false, partial: "item_detail"
      end

    end
  end

  # GET /pos_details/1/edit
  def edit
  end

  # POST /pos_details
  # POST /pos_details.json
  def create
    @pos_detail = PosDetail.new(pos_detail_params)

    respond_to do |format|
      if @pos_detail.save
        format.html { redirect_to @pos_detail, notice: 'Pos detail was successfully created.' }
        format.json { render :show, status: :created, location: @pos_detail }
      else
        format.html { render :new }
        format.json { render json: @pos_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos_details/1
  # PATCH/PUT /pos_details/1.json
  def update
    respond_to do |format|
      if @pos_detail.update(pos_detail_params)
        format.html { redirect_to @pos_detail, notice: 'Pos detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @pos_detail }
      else
        format.html { render :edit }
        format.json { render json: @pos_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos_details/1
  # DELETE /pos_details/1.json
  def destroy
    @pos_detail.destroy
    respond_to do |format|
      format.html { redirect_to pos_details_url, notice: 'Pos detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_detail
      @pos_detail = PosDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pos_detail_params
      params.require(:pos_detail).permit(:company_id, :pharmacy_id, :pos_transaction_id, :ticket_number, :sequence_number, :rx_number, :fill_number, :category, :quantity, :item_type, :item_number, :item_description, :price, :extended_price, :tax_amount, :medical_item, :price_override)
    end
end
