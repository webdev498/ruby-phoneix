class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


# ajax answer the next page for paginated Customer search

  def nextUsers

    searchFor = params[:start] ? params[:start] : ""

    if params[:page]
      @searchUsers = User.paged_by_last_name( searchFor, params[:page], 9)
    else
      @searchUsers = User.paged_by_last_name( searchFor, 1, 9)
    end

    render  template: 'common/search/js/nextSearchUsers.js'

  end


  #	ajax answer the next page for paginated Customer search

  	def nextEmployees

  		if params[:start]
  			@searchFor = params[:start]
  		else
  			@searchFor = ""
  		end

  		if params[:page]
  			@searchEmployees = Employee.paged_search_by_partial(@searchFor, params[:page], 9)
  		else
  			@searchEmployees = Employee.paged_search_by_partial( @searchFor, 1, 9)
  		end

        # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
        # remember, its not quite a standard rails approach
        searchTemplate = render_to_string partial: 'common/search/employee_search_modal_template', locals: { searchEmployees: @searchEmployees }, :layout => false

        # when using the technique above, the newlines (\n) have to be removed
        render js: "$('#employee_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

  	end



  # GET /users/1
  # GET /users/1.json
  def show_user
    @user = User.find( params[:id] )
    render 'userAccount'
  end

  def userAccount
		#testing
		@user = User.new
  end


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  # GET /users/1
  # GET /users/1.json
  def show
    show_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end


  # POST /users
  # POST /users.json
  def create
    params[:user][:active] ||= false   # just in case toggle slider mis-behaves with nil
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    # TODO: need this to be done via a changeUser method in the model
    if params[:commit] == "changeEmployee"

        # argghhhh ... not the right way to do this ... but for now ...
        # point the belongs_to directly to the new user
        target_employee = Employee.find params[:user][:employee_attributes][:id].to_i
        if target_employee.active_flag?
            @user.employee_id = target_employee.id
        end

    end

    set_roles

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # TODO: need to switch to fire this method when changing employee, rather than using standard submit
  def changeEmployee

  end

  private

    def set_roles
        @user.roles.each { |role| @user.remove_role role.name }
        params[:user][:roles].each { |role| @user.add_role role[0] }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:active, :initials, :username, :password, :password_confirmation, :first_name, :last_name, :notes )
    end

end
