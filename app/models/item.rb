class Item < ActiveRecord::Base

  after_initialize :initialize_item

	has_many :priceHistories, -> {order('created_at DESC')}
	has_one :clinicalMaster
	has_many :generic_items, class_name: 'Item', foreign_key: 'brand_item_id'
	belongs_to :'brand_item', class_name: 'Item', foreign_key: 'brand_item_id'
        has_one  :formula
        has_many :ingredients, through: :formula
        accepts_nested_attributes_for :formula
        has_many :item_pedigrees
        has_many :dispenses

#	scope :by_active_drug_name, -> sourceString { where("item_name like '#{sourceString.upcase}%' and active is TRUE") }
        scope :by_drug_name, -> sourceString { where("item_name LIKE '#{sourceString.upcase}%'") }
	scope :by_synonym, -> sourceString { where( synonym: sourceString.upcase ) }
	scope :by_ndc10,   -> sourceString { where( scanned_ndc_number: sourceString ) }
	scope :by_ndc11,   -> sourceString { where( ndc_number: sourceString ) }
	scope :by_gcnseq,  -> sourceString { where( gcnseq_number: sourceString.upcase ) }
  scope :by_active,  -> { where("active is TRUE") }

	enum brand_generic_compound: [ :brand, :generic, :compound ]
  enum dea_schedule: [ :non_scheduled, :experimental, :narcotic, :schedule_3, :schedule_4, :schedule_5, :state_mandated ]
  enum drug_class: [:legend, :over_the_counter, :legend_unit_dose, :otc_unit_dose]
  enum maintenance_code: [:unknown, :not_maintenance, :maintenance]

#validates_presence_of :drug_class, inclusion: { in: %w(O L), message: "OTC/Legend " }
	validates_presence_of :drug_class


  # TODO: the following fields need to be properly adjusted
  attr_accessor :counseling_code1
  attr_accessor :counseling_code2
  attr_accessor :counseling_code3
  attr_accessor :image_description

    # below scope needs to change when brand_generic_compound becomes an enum
#    scope :is_generic, { where ( brand_generic_compound: "G" ) }

	attr_accessor :brand_generic
	attr_accessor :display_name

	# TODO: remove this once ItemPedigree is an ActiveRecord
	attr_accessor :pedigree
  attr_accessor :price_basis
  attr_accessor :price_basis_code

  # touch the relationships on some fields on initialization
  # mostly used on "newly" instantiated objest required by the "new" action
  def initialize_item
      # if we haven't come from a find, then preset some attributes needed by the form
      if !self.id.present?
#          self.id ||= 0
        self.item_name ||= ""
    	  self.image_file_name ||= ""
    	  self.drug_class ||= 0
#          the assignment below forces a record instantiation ??? rails side effect/bug
#          ... so assign the value manuall to Generic value 1
#          self.Generic!
          self.brand_generic_compound = 1
          self.formula = Formula.new
      end

      self.set_display_name
#      self.set_pedigree
  end


	#  paged search by:
	#		ssn
	#		date of birth
	#		phone number
	#		partial name

  def self.search_arel sourceString
    case sourceString.upcase
        # 11 digit NDC
        when /^\d{11}$/
            Item.by_ndc11(sourceString)

        # 10 digit NDC
        when /^\d{10}$/
            Item.by_ndc10(sourceString)

        # Synonym  A******1
        when /^[a-zA-Z]([0-9A-Za-z]{0,4})\d{1}$/
            Item.by_synonym(sourceString)

        else
            Item.by_drug_name(sourceString)
    end
  end


	def self.paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).page(pageNumber).per(perPage)
	end


  def self.active_paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).by_active().page(pageNumber).per(perPage)
	end

  def self.compound_paged_search_by_partial sourceString, pageNumber, perPage
    self.search_arel(sourceString).compound.page(pageNumber).per(perPage)
  end

	#  partial search by:
	#		drug name
	def self.search_by_drug_name sourceString
        items = Item.arel_table
#        Item.where( items[:item_name].matches("%#{sourceString.upcase}%") )
        Item.by_drug_name sourceString.upcase
	end


	#   search by:
	#		GCN_SEQNUMBER
	def self.search_by_gcnseq_number sourceString
		Item.where(gcnseq_number: sourceString.upcase)
	end


# OBSOLETE
	#  search by:
	#		ssn
	#		date of birth
	#		phone number
	#		partial name
	# def self.search_by_partial sourceString
	# 	case sourceString.upcase
  #
	# 		# 11 digit NDC
  #   		when /^\d{11}$/
  #       		Item.where(ndc_number: sourceString)
  #
  # 			# 10 digit NDC
  #   		when /^\d{10}$/
  #        		Item.where(scanned_ndc_number: sourceString)
  #
  # 			# Synonym  A******1
  #   		when /^[a-zA-Z]([0-9A-Za-z]{0,4})\d{1}$/
  #       		Item.where(synonym: sourceString)
  #
	# 		else
	# 		    search_by_drug_name sourceString;
	# 	end
	# end


  #  answer the next batch of items
  #  used by Search
  def self.nextItems searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.paged_search_by_partial searchItem, startPage, pageSize
      else
          self.paged_search_by_partial searchItem, 1, pageSize
      end
  end

#  answer the next batch of itemts that are compounds
#  used by Search
  def self.nextCompounds searchFor, startPage=1, pageSize=9
    searchItem = searchFor ? searchFor : ""
    if startPage
      self.compound_paged_search_by_partial searchItem, startPage, pageSize
    else
      self.compound_paged_search_by_partial searchItem, 1, pageSize
    end
  end

  #  answer the next batch of ACTIVE items
  #  used by Search
  def self.nextActiveItems searchFor, startPage=1, pageSize=9
      searchItem = searchFor ? searchFor : ""
      if startPage
          self.active_paged_search_by_partial searchItem, startPage, pageSize
      else
          self.active_paged_search_by_partial searchItem, 1, pageSize
      end
  end



    def set_display_name
		self.display_name ||= self.item_name
	end

    def full_display_name
		self.brand_generic_compound.capitalize + ":   " + self.display_name
    end

	#  todo: brand_generic_compound to become an enum
	def is_generic?
		self.brand_generic_compound == "G"
	end

	def is_compound?
		self.brand_generic_compound == "C"
	end

	def is_brand?
		self.brand_generic_compound == "B"
	end

	# TODO:  remove pedigree related methods below once ItemPedigree becomes an ActiveRecord
	def set_pedigree
        # TURN OFF Pedigree testing for now
		# self.pedigree = [
		# 	ItemPedigree.new("B-1013-15", "5617832", "MCKESSON", "01/10/2015".to_date, 270,126),
		# 	ItemPedigree.new("LOT-93-15", "10435928", "IPC", "01/06/2015".to_date, 270,101),
		# 	ItemPedigree.new("LT2568415", "203156172", "CARDINAL", "01/01/2015".to_date, 450,20),
		# 	ItemPedigree.new("LOT-93-14", "10105677", "IPC", "22/09/2014".to_date, 360,200),
		# 	ItemPedigree.new("LOT-93-14", "10002310", "IPC", "03/06/2014".to_date, 360,105),
		# 	ItemPedigree.new("LA253-0314", "492513", "AMERISOURCE", "01/01/2014".to_date, 450,28) ]
	end

	def pedigrees
		self.pedigree
  end

  def item_hcpcs_code
    "UNDEFINED"
  end

  def price_basis
    self.price_based_pricing_schedule.nil? ? nil : PriceSchedule.find(self.price_based_pricing_schedule).basis
  end

  def price_basis_code
    self.price_based_pricing_schedule.nil? ? nil : PriceSchedule.find(self.price_based_pricing_schedule).basis.to_i
  end

  def copyFormulaFromExistingItem(formula_id)
    @formulaToCopy = Formula.find(formula_id)

    @ingredientsToCopy = @formulaToCopy.ingredients.map do |i|
      params = i.attributes
      params.delete("id")
      params.delete("formula_id")
      params
    end

    if(self.formula)
      if(self.formula.ingredients.count > 0)
        self.formula.ingredients.each do |ingredient|
          ingredient.delete
        end
      end
      self.formula.delete
    end

    newFormulaParams = @formulaToCopy.attributes
    newFormulaParams.delete("id")
    newFormulaParams["item_id"] = self.id

    newFormula = Formula.create(newFormulaParams)
    @ingredientsToCopy.each do |ingredientParams|
      ingredientParams["formula_id"] = newFormula.id
      Ingredient.create(ingredientParams)
    end
    self.brand_generic_compound = 2 # enum for compound
    self.save
  end
end
