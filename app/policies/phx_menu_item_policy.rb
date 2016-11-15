class PhxMenuItemPolicy < ApplicationPolicy
  attr_reader :user, :record

#
#  Menu Item policies:
#     authorized - has full access to the resource
#     visible - can see the resource in the list, but has no access
#     unauthorized - cannot see the resource in the list
#     an error condition, or misssing reccord information, is equivalent to "unauthorized"

  def authorized?

#	if user.has_role? :admin
#		true
#	else
	  	# for testing, just look at the path ... need to do role check here, based on the :user
	    record.success_path.empty? ? false : true
#	 end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end


end
