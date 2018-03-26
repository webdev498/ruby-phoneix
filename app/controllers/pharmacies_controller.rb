class PharmaciesController < ApplicationController
  before_action :set_pharmacy, only: [:show, :edit, :update, :destroy]



  def nextPharmacies

    if params[:start]
      @searchFor = params[:start]
    else
      @searchFor = ""
    end

    if params[:page]
      @searchPharmacies = Pharmacy.paged_search_by_partial(@searchFor, params[:page], 9)
    else
      @searchPharmacies = Pharmacy.paged_search_by_partial( @searchFor, 1, 9)
    end

    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
#    searchTemplate = render_to_string partial: 'common/search/pharmacy_search_modal_template', locals: { searchPharmacies: @searchPharmacies }, :layout => false

    # when using the technique above, the newlines (\n) have to be removed
#    render js: "$('#pharmacy_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'
    render  template: 'common/search/js/nextSearchPharmacies.js'

  end



  # TODO: remove action below
  def pharmacy
#p = policy( PhxMenu.new( "s_pharmacy_userMaintenance", "s", "User Maintenance", "/this/path1/" ) )
		@pharmacy = Pharmacy.new
 #   authorize @pharmacy
  end




  # GET /pharmacies
  # GET /pharmacies.json
  # def index
  #   @pharmacies = Pharmacy.all
  # end

  # GET /pharmacies/1
  # GET /pharmacies/1.json
  def show
      # TESTING: start with the 1st pharmacy
      @pharmacy = Pharmacy.find 1
      render :edit
  end

  # GET /pharmacies/new
  def new
#    @pharmacy = Pharmacy.find 1
      # TESTING: start with the 1st pharmacy
      @pharmacy = Pharmacy.find 1
  end

  # GET /pharmacies/1/edit
  def edit
  end

  # POST /pharmacies
  # POST /pharmacies.json
  def create

    pharmacy_params[:pharmacy_type] = accountParams[:pharmacy_type].to_i
    pharmacy_params[:us_or_metric] = accountParams[:us_or_metric].to_i
  
    @pharmacy = Pharmacy.new(pharmacy_params)

    respond_to do |format|
      if @pharmacy.save
        format.html { redirect_to @pharmacy, notice: 'Pharmacy was successfully created.' }
        format.json { render :show, status: :created, location: @pharmacy }
      else
        format.html { render :new }
        format.json { render json: @pharmacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pharmacies/1
  # PATCH/PUT /pharmacies/1.json
  def update

    pharmacy_params[:pharmacy_type] = accountParams[:pharmacy_type].to_i
    pharmacy_params[:us_or_metric] = accountParams[:us_or_metric].to_i

    respond_to do |format|

      pharmacy_params[:pharmacy_type] = pharmacy_params[:pharmacy_type].to_i
      pharmacy_params[:us_or_metric] = pharmacy_params[:us_or_metric].to_i

      if @pharmacy.update(pharmacy_params)
        format.html { redirect_to @pharmacy, notice: 'Pharmacy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pharmacy }
      else
        format.html { render :edit }
        format.json { render json: @pharmacy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pharmacies/1
  # DELETE /pharmacies/1.json
  def destroy
  #   @pharmacy.destroy
  #   respond_to do |format|
  #     format.html { redirect_to pharmacies_url, notice: 'Pharmacy was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  end


  #  partial search by:
  #		last name
  #		first name, last name

  def self.search_by_name sourceString

    Pharmacy.where "last_name like '#{names[0]}%'"

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pharmacy
      @pharmacy = Pharmacy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pharmacy_params
      params.require(:pharmacy).permit(:company_id, :active, :pharmacy_name, :address1, :address2, :city, :state, :zip_code, :rna_account_number, :expiration_date, :ncpdp_number, :dea_number, :npi_number, :max_sessions, :federal_tax_id_number, :rx_taxable_flag, :local_tax_rate, :state_tax_rate, :total_tax_rate, :pharmacy_type, :claimguard_counter, :eligibility_counter, :us_or_metric, :promotional_message, :phone_number, :fax_number, :email)
    end
end
