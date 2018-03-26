class ClaimDursController < ApplicationController
  before_action :set_claim_dur, only: [:show, :edit, :update, :destroy]

  # GET /claim_durs
  # GET /claim_durs.json
  def index
    @claim_durs = ClaimDur.all
  end

  # GET /claim_durs/1
  # GET /claim_durs/1.json
  def show
  end

  # GET /claim_durs/new
  def new
    @claim_dur = ClaimDur.new
  end

  # GET /claim_durs/1/edit
  def edit
  end

  # POST /claim_durs
  # POST /claim_durs.json
  def create

    claim_dur_params[:level_of_effort] = claim_dur_params[:level_of_effort].to_i

    @claim_dur = ClaimDur.new(claim_dur_params)

    respond_to do |format|
      if @claim_dur.save
        format.html { redirect_to @claim_dur, notice: 'Claim dur was successfully created.' }
        format.json { render :show, status: :created, location: @claim_dur }
      else
        format.html { render :new }
        format.json { render json: @claim_dur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_durs/1
  # PATCH/PUT /claim_durs/1.json
  def update

    claim_dur_params[:level_of_effort] = claim_dur_params[:level_of_effort].to_i

    respond_to do |format|
      if @claim_dur.update(claim_dur_params)
        format.html { redirect_to @claim_dur, notice: 'Claim dur was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_dur }
      else
        format.html { render :edit }
        format.json { render json: @claim_dur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_durs/1
  # DELETE /claim_durs/1.json
  def destroy
    @claim_dur.destroy
    respond_to do |format|
      format.html { redirect_to claim_durs_url, notice: 'Claim dur was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_dur
      @claim_dur = ClaimDur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_dur_params
      params.require(:claim_dur).permit(:dept_number, :rna_plan_id_code, :rx_number, :fill_number, :overflow_flag, :sent_counter, :reason_for_service, :result_code, :service_code, :level_of_effort, :coagent_id, :coagent_qualifier, :receive_counter, :dur_code, :dur_severity, :dur_pharmacy, :dur_date, :dur_quantity, :dur_database, :dur_prescriber, :dur_message)
    end
end
