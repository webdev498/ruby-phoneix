class SupervisingPrescribersController < ApplicationController

    before_action :set_prescriber, only: [:show, :edit, :update, :destroy]


    # ajax answer the next page for paginated Prescriber search
    def nextPrescribers
      @searchPrescribers = Prescriber.nextPrescribers params[:start], params[:page], 9
      render  template: 'common/search/js/nextSearchPrescribers.js'
    end


  # def prescriber
  # @prescriber = Prescriber.find(1)
  # end


  # GET /prescribers
  # GET /prescribers.json
  # def index
  #   #@prescribers = Prescriber.all
  #   redirect_to :controller => 'searches', :action => 'new', :searching_for => 'prescriber'
  # end

  # GET /prescribers/1
  # GET /prescribers/1.json
  def show
      render :edit
  end

  # GET /prescribers/new
  def new
    @prescriber = Prescriber.new
  end

  # GET /prescribers/1/edit
  def edit
  end


  # DELETE /prescribers/1
  # DELETE /prescribers/1.json
  def destroy
    @prescriber.destroy
    respond_to do |format|
      format.html { redirect_to prescribers_url, notice: 'Prescriber was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def supervisors
    # not exactly the way I would like it .. but should suffice for now
#    @prescriber = Prescriber.new

    @prescriber = Prescriber.find 1
    render :edit
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescriber
      @prescriber = Prescriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescriber_params
      params.require(:prescriber).permit(:dept_number, :rna_prescriber_id_number, :last_name, :first_name, :middle_name, :dea_number, :npi_number, :surescripts_erx_id, :emdeon_erx_id, :active_flag, :participates_in_340b, :location_code, :requires_supervisor, :address1, :address2, :city, :state, :zip_code, :specialty, :memo, :group_code, :sig_default, :erx_eligibility, :remote_access, :facility_number, :allowed_to_prescribe_narcotics, :allowed_to_prescribe_controlled, :alternate_id1_qualifier, :alternate_id1, :alternate_id1_source, :alternate_id2_qualifier, :alternate_id2, :alternate_id2_source, :alternate_id3_qualifier, :alternate_id3, :alternate_id3_source, :alternate_id4_qualifier, :alternate_id4, :alternate_id4_source)
    end
end
