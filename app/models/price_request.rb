class PriceRequest

  def initialize(params = {})
    @item = Item.find(params[:item_id]) if params[:item_id]
    @plan = Plan.find(params[:plan_id]) if params[:plan_id]
    @facility = Facility.find[:facility_id] if params[:facility_id]
    @wing = Wing.find[:wing_id] if params[:wing_id]
    @customer = Customer.find[:customer_id] if params[:customer_id]
    @quantity = params[:quantity]
    @days_supply = params[:days_supply]
    @params = params
  end

  def evaluate_schedule(schedule)
    if schedule.active == false
      puts "not active"
      return false
    end
    if getPrice(schedule.basis) == 0.0
      puts "price is 0"
      return false
    end
    if schedule.qualifier != :default
      if schedule.qualifier == :generic && @item.brand_generic_compound != :generic
        puts "not generic"
        return false
      end
      if schedule.qualifier == :brand && @item.brand_generic_compound != :brand
        puts "not brand"
        return false
      end
      if schedule.qualifier == :compound && @item.brand_generic_compound != :compound
        puts "not compound"
        return false
      end
      if schedule.qualifier == :over_the_counter && @item.drug_class != :over_the_counter
        puts "not otc"
        return false
      end
      if schedule.qualifier == :controlled && @item.dea_schedule == :no_schedule
        puts "not controlled"
        return false
      end
      if schedule.qualifier == :unit_dose && @item.drug_class != :legend_unit_dose && @item.drug_class != :otc_unit_dose
        puts "not unit dose"
        return false
      end
      if check_exact_hit(schedule) == false
        puts "not exact hit"
        return false
      end
      return true
    else
      puts "qualifier is default"
      return true
    end

  end

  def check_exact_hit(schedule)
    hit_found = false
    if schedule.break_type == :quantity_based && schedule.exact_hit == true
      schedule.priceBreaks.where("markup_percent != 0").order(:break_limit).each do |price_break|
        if schedule.break_limit.to_i == @quantity.to_i
          hit_found = true
          break
        end
      end
      return hit_found
    elsif schedule.break_type == :quantity_based && schedule.exact_hit == false
      return true
    end

  end

  def calculate_price
    plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule = find_schedules
    schedule = select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
    if schedule
      base_cost = calculate_base_cost(schedule)
      fee1, markup_percent = find_percentage_fee(base_cost, schedule)
      fee2 = find_amount_fee(base_cost, schedule)
      return [(base_cost + fee1 + fee2), schedule, base_cost, markup_percent, fee2]
    else
      return [nil, nil, nil, nil, nil]
    end
  end

  def calculate_usual_and_customary
    plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule = find_schedules
    if price_based_schedule
      base_cost = calculate_base_cost(price_based_schedule)
      fee1, markup_percent = find_percentage_fee(base_cost, price_based_schedule)
      fee2 = find_amount_fee(base_cost, price_based_schedule)
      return (base_cost + fee1 + fee2)
    else
      return nil
    end
  end

  def process
    price, schedule, base_cost, markup_percent, markup_amount = calculate_price
    acquisition_cost = @item.act_unit_price * @quantity
    usual_customary_price = calculate_usual_and_customary
    return @params[:company_id], @params[:pharmacy_id], schedule.id, schedule.name, price, base_cost,
           acquisition_cost, markup_percent, markup_amount, schedule.basis, schedule.discounts_allowed, usual_customary_price,
           @params[:quantity]
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
        facility_schedule = PriceSchedule.find(@wing.price_based_pricing_schedule) if @wing && @wing.price_based_pricing_schedule
        customer_schedule = PriceSchedule.find(@customer.price_based_pricing_schedule) if @customer && @customer.price_based_pricing_schedule
        return [plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule]
      end

      def select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
        if plan_schedule && evaluate_schedule(plan_schedule) == true
          return plan_schedule
        elsif facility_schedule && evaluate_schedule(facility_schedule) == true
          return facility_schedule
        elsif customer_schedule && customer_schedule.customer_assigned_schedule == :in_addition_to && evaluate_schedule(customer_schedule) == true
          return customer_schedule
        elsif quantity_based_schedule && evaluate_schedule(quantity_based_schedule) == true
          return quantity_based_schedule
        elsif price_based_schedule && evaluate_schedule(price_based_schedule) == true
          return price_based_schedule
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
        markup_percent = 0.0
        max = 0
        if schedule.break_type == :quantity_based
          value_to_compare = @quantity
        else
          value_to_compare = base_cost
        end
        schedule.priceBreaks.where("markup_percent != 0").order(:break_limit).each do |price_break|
          max = price_break.break_limit
          if value_to_compare > min && value_to_compare <= max
            markup_percent = price_break.markup_percent
            fee = base_cost.to_f * (price_break.markup_percent/100.0)
            break
          end
          min = max
        end
        return [fee, markup_percent]
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
