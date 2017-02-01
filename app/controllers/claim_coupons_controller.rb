class ClaimCouponsController < ApplicationController
  before_action :set_claim_coupon, only: [:show, :edit, :update, :destroy]

  # GET /claim_coupons
  # GET /claim_coupons.json
  def index
    @claim_coupons = ClaimCoupon.all
  end

  # GET /claim_coupons/1
  # GET /claim_coupons/1.json
  def show
  end

  # GET /claim_coupons/new
  def new
    @claim_coupon = ClaimCoupon.new
  end

  # GET /claim_coupons/1/edit
  def edit
  end

  # POST /claim_coupons
  # POST /claim_coupons.json
  def create

    claim_coupon_params[:coupon_type] = claim_coupon_params[:coupon_type].to_i

    @claim_coupon = ClaimCoupon.new(claim_coupon_params)

    respond_to do |format|
      if @claim_coupon.save
        format.html { redirect_to @claim_coupon, notice: 'Claim coupon was successfully created.' }
        format.json { render :show, status: :created, location: @claim_coupon }
      else
        format.html { render :new }
        format.json { render json: @claim_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_coupons/1
  # PATCH/PUT /claim_coupons/1.json
  def update

    claim_coupon_params[:coupon_type] = claim_coupon_params[:coupon_type].to_i

    respond_to do |format|
      if @claim_coupon.update(claim_coupon_params)
        format.html { redirect_to @claim_coupon, notice: 'Claim coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_coupon }
      else
        format.html { render :edit }
        format.json { render json: @claim_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_coupons/1
  # DELETE /claim_coupons/1.json
  def destroy
    @claim_coupon.destroy
    respond_to do |format|
      format.html { redirect_to claim_coupons_url, notice: 'Claim coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_coupon
      @claim_coupon = ClaimCoupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_coupon_params
      params.require(:claim_coupon).permit(:dept_number, :rx_number, :rna_plan_id_code, :coupon_number, :coupon_type, :coupon_amount)
    end
end
