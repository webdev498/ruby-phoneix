class DispenseCompoundItem < ActiveRecord::Base
  belongs_to :dispense_compound
  
  enum basis_cost: [ :AWP, :ACT, :MAC, :basis_340b, :WAC, :contract, :NADAC, :custom, :user ]
end
