class Pricebreak < ActiveRecord::Base
    belongs_to :priceschedule
    enum pct_or_amount: [:pct, :amount]
end
