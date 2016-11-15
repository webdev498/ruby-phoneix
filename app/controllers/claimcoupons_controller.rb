class ClaimcouponsController < ApplicationController
  before_action :set_claimcoupon, only: [:show, :edit, :update, :destroy]

  # GET /claimcoupons
  # GET /claimcoupons.json
  def index
    @claimcoupons = Claimcoupon.all
  end

  # GET /claimcoupons/1
  # GET /claimcoupons/1.json
  def show
  end

  # GET /claimcoupons/new
  def new
    @claimcoupon = Claimcoupon.new
  end

  # GET /claimcoupons/1/edit
  def edit
  end

  # POST /claimcoupons
  # POST /claimcoupons.json
  def create
    @claimcoupon = Claimcoupon.new(claimcoupon_params)

    respond_to do |format|
      if @claimcoupon.save
        format.html { redirect_to @claimcoupon, notice: 'Claimcoupon was successfully created.' }
        format.json { render :show, status: :created, location: @claimcoupon }
      else
        format.html { render :new }
        format.json { render json: @claimcoupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claimcoupons/1
  # PATCH/PUT /claimcoupons/1.json
  def update
    respond_to do |format|
      if @claimcoupon.update(claimcoupon_params)
        format.html { redirect_to @claimcoupon, notice: 'Claimcoupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @claimcoupon }
      else
        format.html { render :edit }
        format.json { render json: @claimcoupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claimcoupons/1
  # DELETE /claimcoupons/1.json
  def destroy
    @claimcoupon.destroy
    respond_to do |format|
      format.html { redirect_to claimcoupons_url, notice: 'Claimcoupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimcoupon
      @claimcoupon = Claimcoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claimcoupon_params
      params.require(:claimcoupon).permit(:dept_number, :rx_number, :rna_plan_id_number, :coupon_number, :coupon_type, :coupon_amount)
    end
end
