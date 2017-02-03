class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :edit, :update, :destroy]


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

    # # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # # remember, its not quite a standard rails approach
    # searchTemplate = render_to_string partial: 'common/search/employee_search_modal_template', locals: { searchEmployees: @searchEmployees }, :layout => false
    #
    # # when using the technique above, the newlines (\n) have to be removed
    # render js: "$('#employee_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

    render  template: 'common/search/js/nextSearchEmployees.js'

  end


  # GET /employees
  # GET /employees.json
  #def index
  #  @employees = Employee.all
  #end

  # GET /employees/1
  # GET /employees/1.json
  def show
      render :edit
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:company_id, :pharmacy_id, :person_image_id, :employee_id_number, :active, :last_name, :first_name, :middle_name, :initials, :address1, :address2, :city, :state, :zip_code, :social_security_number, :password, :date_hired, :date_left, :employee_title, :credentials, :npi_number, :license_number, :alternate_id_number, :phone, :fax, :email)
    end
end
