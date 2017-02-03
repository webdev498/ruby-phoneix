$LOAD_PATH.unshift File.expand_path(Dir.pwd)

require "app/models/item"
require "app/models/price_request"

namespace "tst" do
  desc "test price schedule methods"
  task :price_schedule => :environment do
    item = Item.where("price_based_pricing_schedule > 0").last
    request = PriceRequest.create({item_id: item.id, quantity: 100})
    isok = request.process
    puts "isok = " + isok.inspect.to_s
    # plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule = request.find_schedules
    # schedule = request.select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
    # base_cost = request.calculate_base_cost(schedule)
    # fee1 = request.find_percentage_fee(base_cost, schedule)
    # fee2 = request.find_amount_fee(base_cost, schedule)
    # puts base_cost.to_s + "," + fee1.to_s + "," + fee2.to_s + "\n"
  end
end
