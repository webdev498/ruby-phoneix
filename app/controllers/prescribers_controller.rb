class PrescribersController < ApplicationController

  before_action :set_prescriber, only: [:show, :edit, :update, :destroy]

  #  ajax answer the next page for paginated Item search

  def nextPrescribers

    @searchPrescribers = Prescriber.nextPrescribers params[:start], params[:page], 9
    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
#    searchTemplate = render_to_string partial: 'common/search/prescriber_search_modal_template', locals: { searchPrescribers: @searchPrescribers }, :layout => false

    # when using the technique above, the newlines (\n) have to be removed
#    render js: "$('#prescriber_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'
    render  template: 'common/search/js/nextSearchPrescribers.js'

  end


  def nextSupervisePrescribers
    @searchSupervisePrescribers = Prescriber.nextPrescribers params[:start], params[:page], 9
    render  template: 'common/search/js/nextSearchSupervisePrescribers.js'
  end


  # GET /prescribers
  # GET /prescribers.json
  # def index
  #   #@prescribers = Prescriber.all
  #   redirect_to :controller => 'searches', :action => 'new', :searching_for => 'prescriber'
  # end

  # GET /prescribers/1
  # GET /prescribers/1.json
  def show
    @prescriber.prepare_contact_points_for_view
    render :edit
  end

  # GET /prescribers/new
  def new
    @prescriber = Prescriber.new
  end

  # GET /prescribers/1/edit
  def edit
    @prescriber.prepare_contact_points_for_view
  end

  def supervisor
    @prescriber = (params[:id]) ? (Prescriber.find params[:id]) : Prescriber.new
    render "supervising_prescribers"
  end



  def changeSupervisors
    @prescriber = Prescriber.new
    render "supervising_prescribers"
  end


  def supervising
    render "supervising_prescribers"
  end


  def addPrescriberSupervisor
    @prescriber = Prescriber.find params[:id]
    @prescriber.supervisors << (Prescriber.find params[:supervisor_id])
    # can't contain parent or duplicate supervisor
    if !(@prescriber.supervisors.detect { |ps| (ps.id == params[:id].to_i) or (ps.id == params[:supervisor_id].to_i)  } )
# => @prescriber.save
    end
  end


  def addPrescriberSupervisee
      @prescriber = Prescriber.find params[:id]
      @prescriber.supervisee << (Prescriber.find params[:supervisee_id])
      # can't contain parent or duplicate supervisor
      if !(@prescriber.supervisees.detect { |ps| (ps.id == params[:id].to_i) or (ps.id == params[:supervisee_id].to_i)  } )
  # => @prescriber.save
      end
  end


  # POST /prescribers
  # POST /prescribers.json
  def create
    @prescriber = Prescriber.new(prescriber_params)

    @prescriber.last_name   = @prescriber.last_name.upcase
    @prescriber.first_name  = @prescriber.first_name.upcase
    @prescriber.middle_name = @prescriber.middle_name.upcase
    @prescriber.address1    = @prescriber.address1.upcase
    @prescriber.address2    = @prescriber.address2.upcase
    @prescriber.city        = @prescriber.city.upcase
    @prescriber.state       = @prescriber.state.upcase
    @prescriber.zip_code    = @prescriber.zip_code.upcase

    params[:prescriber][:receive_messages] = params[:prescriber][:receive_messages].to_i
    params[:prescriber][:alternate_id1_qualifier] = params[:prescriber][:alternate_id1_qualifier].to_i
    params[:prescriber][:alternate_id2_qualifier] = params[:prescriber][:alternate_id2_qualifier].to_i
    params[:prescriber][:alternate_id3_qualifier] = params[:prescriber][:alternate_id3_qualifier].to_i
    params[:prescriber][:alternate_id4_qualifier] = params[:prescriber][:alternate_id4_qualifier].to_i

    set_contact_points

    respond_to do |format|
      if @prescriber.save
        format.html { redirect_to @prescriber, notice: 'Prescriber was successfully created.' }
        format.json { render :show, status: :created, location: @prescriber }
      else
        format.html { render :new }
        format.json { render json: @prescriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prescribers/1
  # PATCH/PUT /prescribers/1.json
  def update

    set_contact_points

    @prescriber.last_name = @prescriber.last_name.upcase
    @prescriber.first_name = @prescriber.first_name.upcase
    @prescriber.middle_name = @prescriber.middle_name.upcase
    @prescriber.address1 = @prescriber.address1.upcase
    @prescriber.address2 = @prescriber.address2.upcase
    @prescriber.city = @prescriber.city.upcase
    @prescriber.state = @prescriber.state.upcase
    @prescriber.zip_code = @prescriber.zip_code.upcase
    params[:prescriber][:receive_messages] = params[:prescriber][:receive_messages].to_i
    params[:prescriber][:alternate_id1_qualifier] = params[:prescriber][:alternate_id1_qualifier].to_i
    params[:prescriber][:alternate_id2_qualifier] = params[:prescriber][:alternate_id2_qualifier].to_i
    params[:prescriber][:alternate_id3_qualifier] = params[:prescriber][:alternate_id3_qualifier].to_i
    params[:prescriber][:alternate_id4_qualifier] = params[:prescriber][:alternate_id4_qualifier].to_i

    respond_to do |format|
      if @prescriber.update(prescriber_params)
        format.html { redirect_to @prescriber, notice: 'Prescriber was successfully updated.' }
        format.json { render :show, status: :ok, location: @prescriber }
      else
        format.html { render :edit }
        format.json { render json: @prescriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescribers/1
  # DELETE /prescribers/1.json
  def destroy
    # @prescriber.destroy
    # respond_to do |format|
    #   format.html { redirect_to prescribers_url, notice: 'Prescriber was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end


  # arggggghhh ugly
  # TODO: fix this
  def set_contact_points
    p_params = params[:prescriber]
    # arggggghhh
    # TODO: fix below
    @prescriber.contact_points.delete_all
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:phone1], kind: ContactPoint.kinds[:phone], use: ContactPoint.uses[:work], rank: 1)
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:phone2], kind: ContactPoint.kinds[:phone], use: ContactPoint.uses[:work], rank: 2)
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:mobile1], kind: ContactPoint.kinds[:mobile], use: ContactPoint.uses[:work], rank: 3)
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:home_phone1], kind: ContactPoint.kinds[:phone], use: ContactPoint.uses[:home], rank: 4)
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:fax1], kind: ContactPoint.kinds[:fax], use: ContactPoint.uses[:work], rank: 5)
    @prescriber.contact_points << ContactPoint.new( contact: p_params[:email1], kind: ContactPoint.kinds[:email], use: ContactPoint.uses[:work], rank: 6)
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_prescriber
      @prescriber = Prescriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prescriber_params
      params.require(:prescriber).permit(:company_id, :pharmacy_id_number, :person_image_id, :last_name, :first_name, :middle_name,
          :dea_number, :npi_number, :surescripts_erx_id, :alternate_erx_id_number, :active, :participates_in_340b, :location_code,
          :requires_supervisor, :address1, :address2, :city, :state, :zip_code, :phone, :fax_number, :cell_number, :email,
          :receive_messages, :specialty, :notes, :memo, :group_code, :sig_default,
          :erx_eligibility, :remote_access, :facility_number, :allowed_to_prescribe_narcotics, :allowed_to_prescribe_controlled,
          :alternate_id1_qualifier, :alternate_id1, :alternate_id1_source, :alternate_id2_qualifier, :alternate_id2, :alternate_id2_source,
          :alternate_id3_qualifier, :alternate_id3, :alternate_id3_source, :alternate_id4_qualifier, :alternate_id4, :alternate_id4_source)
    end
end
