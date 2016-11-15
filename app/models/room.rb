class Room < ActiveRecord::Base
  belongs_to :facility
  belongs_to :wing
end
