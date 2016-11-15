class PriceSchedulesController < ApplicationController
  before_action :set_price_schedule, only: [:show, :edit, :update, :destroy]


  def nextPriceSchedules

    @searchPriceSchedules = PriceSchedule.nextPriceSchedules params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchPriceSchedules.js'

  end


  # GET /price_schedules/1
  # GET /price_schedules/1.json
  def show
      render :edit
   end

  # GET /price_schedules/new
  def new
#    @price_schedule = PriceSchedule.new
    @price_schedule = PriceSchedule.find 1
  end

  # GET /price_schedules/1/edit
  def edit
  end

  # POST /price_schedules
  # POST /price_schedules.json
  def create
    @price_schedule = PriceSchedule.new(price_schedule_params)

    respond_to do |format|
      if @price_schedule.save
        format.html { redirect_to @price_schedule, notice: 'Price Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @price_schedule }
      else
        format.html { render :new }
        format.json { render json: @price_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_schedules/1
  # PATCH/PUT /price_schedules/1.json
  def update
    respond_to do |format|
      if @price_schedule.update(price_schedule_params)
        format.html { redirect_to @price_schedule, notice: 'Price Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_schedule }
      else
        format.html { render :edit }
        format.json { render json: @price_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_schedules/1
  # DELETE /price_schedules/1.json
  def destroy
    @price_schedule.destroy
    respond_to do |format|
      format.html { redirect_to price_schedules_url, notice: 'Price Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_schedule
      @price_schedule = PriceSchedule.find( params[:id] )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_schedule_params
      params.require(:price_schedule).permit( :schedule_number, :active_flag, :schedule_basis, :schedule_name, :break_type, :schedule_type, :schedule_modifier, :discounts_allowed, :cumulative, :require_exact_hit, :require_rounding, :rounding_amount, :percentage_fee_type, :amount_fee_type)
    end
end
