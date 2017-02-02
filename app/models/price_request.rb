class PriceRequest

  def initialize(params = {})
    @item = Item.find(params[:item_id]) if params[:item_id]
    @plan = Plan.find(params[:plan_id]) if params[:plan_id]
    @facility = Facility.find[:facility_id] if params[:facility_id]
    @customer = Customer.find[:customer_id] if params[:customer_id]
    @quantity = params[:quantity]
    @days_supply = params[:days_supply]
  end



  def calculate_price
    plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule = find_schedules
    schedule = select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
    base_cost = calculate_base_cost(schedule)
    fee1 = find_percentage_fee(base_cost, schedule)
    fee2 = find_amount_fee(base_cost, schedule)
    return base_cost + fee1 + fee2
  end


    private

      def find_schedules
        price_based_schedule = nil
        quantity_based_schedule = nil
        plan_schedule = nil
        facility_schedule = nil
        customer_schedule = nil
        price_based_schedule = PriceSchedule.find(@item.price_based_pricing_schedule) if @item && @item.price_based_pricing_schedule
        quantity_based_schedule = PriceSchedule.find(@item.quantity_based_pricing_schedule) if @item && @item.quantity_based_pricing_schedule
        plan_schedule = PriceSchedule.find(@plan.price_based_pricing_schedule) if @plan && @plan.price_based_pricing_schedule
        # TODO facility price schedule
        customer_schedule = PriceSchedule.find(@customer.price_based_pricing_schedule) if @customer && @customer.price_based_pricing_schedule
        return [plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule]
      end

      def select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
        if plan_schedule
          return plan_schedule
        elsif facility_schedule
          return facility_schedule
        elsif customer_schedule
          return customer_schedule
        elsif price_based_schedule
          return price_based_schedule
        elsif quantity_based_schedule
          return quantity_based_schedule
        else
          return nil
        end
      end

      def calculate_base_cost(price_schedule)
        unit_price = getPrice(price_schedule.basis)
        base_cost = unit_price * @quantity
      end

      def getPrice(price_basis)
        price = nil
        case (price_basis.to_i)
          when 0#[:awp]
            price = @item.awp_unit_price
          when 1 #[:act]
            price = @item.act_unit_price
          when 2 #[:basis_340b]
            price = @item.govt_340b_unit_price
          when 3 #[:wac]
            price = @item.wac_unit_price
          when 4 #[:contract]
            price = @item.contract_unit_price
          when 5 #[:nadac]
            price = @item.nadac_unit_price
          when 6 #[:custom]
            price = @item.custom_unit_price
          when 7 #[:user]
            price = @item.mac_unit_price
          else
            price = nil
        end
        price
      end

      def find_percentage_fee(base_cost, schedule)
        min = 0
        fee = 0.0
        max = 0
        schedule.priceBreaks.where("markup_percent != 0").order(:break_limit).each do |price_break|
          max = price_break.break_limit
          if base_cost > min && base_cost <= max
            fee = base_cost.to_f * (price_break.markup_percent/100.0)
            break
          end
          min = max
        end
        return fee
      end

      def find_amount_fee(base_cost, schedule)
        min = 0
        fee = 0.0
        max = 0
        schedule.priceBreaks.where("markup_amount != 0").order(:break_limit).each do |price_break|
          max = price_break.break_limit
          if base_cost > min && base_cost <= max
            fee = price_break.markup_amount
            break
          end
          min = max
        end
        return fee
      end

end
