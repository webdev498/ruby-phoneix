$LOAD_PATH.unshift File.expand_path(Dir.pwd)

require "app/models/item"
require "app/models/price_request"

namespace "tst" do
  desc "test price schedule methods"
  task :price_schedule => :environment do
    item = Item.first
    request = PriceRequest.new({item_id: item.id, quantity: 100})
    plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule = request.find_schedules
    schedule = request.select_applicable_schedule(plan_schedule, facility_schedule, customer_schedule, price_based_schedule, quantity_based_schedule)
binding.pry
    base_cost = request.calculate_price(schedule)
    fee = request.find_percentage_fee(base_cost, schedule)
    puts base_cost.to_s + "," + fee.to_s
  end
end
