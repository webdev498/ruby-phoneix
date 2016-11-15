class Sigcode < ActiveRecord::Base

	after_initialize :initialize_sigcode

	enum language: [:english, :spanish]

	scope :by_code, -> sourceString { where("sig_code like '#{sourceString.upcase}%'") }


	attr_accessor :display_name

	# touch the relationships on some fields on initialization
  # mostly used on "newly" instantiated objest required by the "new" action
  def initialize_sigcode
      # if we haven't come from a find, then preset some attributes needed by the form
      if !self.id.present?
        self.language ||= :english
    	  self.active ||= true
      end
  end


	def self.paged_search_by_partial sourceString, pageNumber, perPage
		self.by_code(sourceString).page(pageNumber).per(perPage)
		# TODO: TESTING answer all
# 		self.all.page(pageNumber).per(perPage)
	end


	#  answer the next batch of Prescribers
    def self.nextSigcodes searchFor, startPage=1, pageSize=9

        searchSigcodes = searchFor ? searchFor : ""
        if startPage
            self.paged_search_by_partial searchSigcodes, startPage, pageSize
        else
            self.paged_search_by_partial searchSigcodes, 1, pageSize
        end

    end


	def display_name
		(self.expanded_text)[0..20]
	end

end
