class PhxMenuPolicy < ApplicationPolicy
  attr_reader :user, :record

  def visible?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end


end
