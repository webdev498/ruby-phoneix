class Bed < ActiveRecord::Base
  belongs_to :facility
  belongs_to :wing
  belongs_to :room
  belongs_to :residency
end
