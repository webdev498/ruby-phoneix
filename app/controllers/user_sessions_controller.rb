class UserSessionsController < ApplicationController

  # render NEW session
  def new
#    @user_acceptance_agreement = License.where( :license_type => 1 ).order( :section )
    render :layout => 'signin'
  end


  # TODO: role user_rph needs to come from Role and the resource authorizations in the db
  def create

#	user = User.find_by_initials(params[:initials])
	user = User.find_by_username(params[:initials])

    if !user.nil? && user.authenticate(params[:pword])
      session[:user_id] = user.id
      session[:initials] = user.initials
      session[:role] = :usr_rph   # during testing
      redirect_to menu_prescription_path
    else
      flash.now.alert = "Invalid initials or password"
      redirect_to root_path
    end

  end


  def destroy
    session[:user_id] = nil
    session[:username] = nil
    session[:role] = nil
    @current_user = nil

# completely kill the session
#    reset_session

    redirect_to root_path, :notice => "Logged out of Phoenix"
  end


end
