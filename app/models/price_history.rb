class PriceHistory < ActiveRecord::Base

	belongs_to :item

	enum mechanism: [:manual, :automatic]
	enum element_changed: [:AWP, :ACT, :MAC, :basis_340b, :WAC, :contract, :NADAC, :custom, :user]

end
