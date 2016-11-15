class CompaniesController < ApplicationController

      before_action :set_company, only: [:show, :edit, :update, :destroy]


  def nextCompanies

    if params[:start]
      @searchFor = params[:start]
    else
      @searchFor = ""
    end

    if params[:page]
      @searchCompanies = Company.paged_search_by_partial(@searchFor, params[:page], 9)
    else
      @searchCompanies = Company.paged_search_by_partial( @searchFor, 1, 9)
    end

    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
    searchTemplate = render_to_string partial: 'common/search/company_search_modal_template', locals: { searchCompanies: @searchCompanies }, :layout => false

    # when using the technique above, the newlines (\n) have to be removed
    render js: "$('#company_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

#    render  template: 'common/search/js/nextsearchCompanies.js'

  end


  # GET /companies
  # GET /companies.json
  #def index
  #  @companies = company.all
  #end

  # GET /companies/1
  # GET /companies/1.json
  def show
      render :edit
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
######    @company.destroy
    @company.active = false
    @company.save
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'company was successfully INACTIVATED.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # TODO: change authorizations for updates to license_id
    def company_params
      params.require(:company).permit( :number, :active, :license_id, :name, :description,
            :address1, :address2, :city, :state, :zip_code, :phone_number, :account_number, :memo )
    end

end
