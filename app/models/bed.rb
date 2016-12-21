class Bed < ActiveRecord::Base
  belongs_to :facility
  belongs_to :wing
  belongs_to :residency
  belongs_to :customer
end
