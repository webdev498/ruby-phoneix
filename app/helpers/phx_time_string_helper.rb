module PhxTimeStringHelper

  # Extend class Date with the phx date string
  # - might need others like DateTime
  class ::Date
    def to_phxTimeString
      self.strftime("%I:%M %p")
    end
  end

  # Extend class Date with the phx date string
  # - might need others like DateTime
  class ::Time
    def to_phxTimeString
      self.strftime("%I:%M %p")
    end
  end

  # Extend class "nil" with the phx date string
  # - rails view builder knows how to handle nil for date
  class ::NilClass
    def to_phxTimeString
      nil
    end
  end

end
