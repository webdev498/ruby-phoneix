module PhxDateStringHelper

  # Extend class Date with the phx date string
  # - might need others like DateTime
  class ::Date
    def to_phxDateString
      self.strftime("%m-%d-%Y")
    end
  end

  # Extend class Date with the phx date string
  # - might need others like DateTime
  class ::Time
    def to_phxDateString
      self.strftime("%m-%d-%Y")
    end
  end

  # Extend class "nil" with the phx date string
  # - rails view builder knows how to handle nil for date
  class ::NilClass
    def to_phxDateString
      nil
    end
  end

end
