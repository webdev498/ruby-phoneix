class Residency < ActiveRecord::Base
  belongs_to :customer
  belongs_to :facility
end
