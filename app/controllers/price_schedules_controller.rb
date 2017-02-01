class PriceSchedulesController < ApplicationController
  before_action :set_price_schedule, only: [:show, :edit, :update, :destroy]


  def nextPriceSchedules

    @searchPriceSchedules = PriceSchedule.nextPriceSchedules params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchPriceSchedules.js'

  end


  # GET /price_schedules/1
  # GET /price_schedules/1.json
  def show
      sch_num = params[:number]
      if(sch_num)
        sch = PriceSchedule.find_by number: sch_num
        if (sch)
          @price_schedule = sch
        end
      end

      if @price_schedule.break_type == 'price_based'
        @b_w = "Cost up to:"
      else
        @b_w = "Qty up to:"
      end
      render :edit
   end

  # GET /price_schedules/new
  def new
    @price_schedule = PriceSchedule.new
   # @price_schedule = PriceSchedule.find 1
  end

  # GET /price_schedules/1/edit
  def edit
  end

  # POST /price_schedules
  # POST /price_schedules.json
  def create

    price_schedule_params[:basis] = price_schedule_params[:basis].to_i
    price_schedule_params[:break_type] = price_schedule_params[:break_type].to_i
    price_schedule_params[:qualifier] = price_schedule_params[:qualifier].to_i
    price_schedule_params[:fee_calculation_type] = price_schedule_params[:fee_calculation_type].to_i
    price_schedule_params[:usual_customary_calculation] = price_schedule_params[:usual_customary_calculation].to_i
    price_schedule_params[:customer_assigned_schedule] = price_schedule_params[:customer_assigned_schedule].to_i
    price_schedule_params[:percentage_fee_type] = price_schedule_params[:percentage_fee_type].to_i
    price_schedule_params[:amount_fee_type] = price_schedule_params[:amount_fee_type].to_i

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

    price_schedule_params[:basis] = price_schedule_params[:basis].to_i
    price_schedule_params[:break_type] = price_schedule_params[:break_type].to_i
    price_schedule_params[:qualifier] = price_schedule_params[:qualifier].to_i
    price_schedule_params[:fee_calculation_type] = price_schedule_params[:fee_calculation_type].to_i
    price_schedule_params[:usual_customary_calculation] = price_schedule_params[:usual_customary_calculation].to_i
    price_schedule_params[:customer_assigned_schedule] = price_schedule_params[:customer_assigned_schedule].to_i
    price_schedule_params[:percentage_fee_type] = price_schedule_params[:percentage_fee_type].to_i
    price_schedule_params[:amount_fee_type] = price_schedule_params[:amount_fee_type].to_i

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
      params.require(:price_schedule).permit( :company_id, :pharmacy_id, :number, :active, :basis, :name, :break_type, :qualifier, :fee_calculation_type, :usual_customary_calculation, :customer_assigned_schedule, :generic_percentage_calculation, :discounts_allowed, :cumulative, :require_exact_hit, :round_price, :round_to_amount, :percentage_fee_type, :amount_fee_type)
    end
end
