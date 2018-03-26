class SigcodesController < ApplicationController

    before_action :set_sigcode, only: [:show, :edit, :update, :destroy]


    # TODO: filter sigcodes at some point
    def nextSigcodes
        @searchSigcodes = Sigcode.nextSigcodes params[:start], params[:page], 9
        render  template: 'common/search/js/nextSearchSigcodes.js'
    end


  # GET /sigcodes/1
  # GET /sigcodes/1.json
  def show
      render "sigCode"
  end

  # GET /sigcodes/new
  def new
    @sigcode = Sigcode.new
  end

  # GET /sigcodes/1/edit
  def edit
  end

  def sigCode
    #testing
    @sigcode = Sigcode.new
  end

# POST /sigcodes
  # POST /sigcodes.json
  def create

    sigcode_params[:language] = sigcode_params[:language].to_i
    sigcode_params[:frequency] = sigcode_params[:frequency].to_i

    @sigcode = Sigcode.new(sigcode_params)

    respond_to do |format|
      if @sigcode.save
        format.html { redirect_to @sigcode, notice: 'Sigcode was successfully created.' }
        format.json { render :show, status: :created, location: @sigcode }
      else
        format.html { render :new }
        format.json { render json: @sigcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sigcodes/1
  # PATCH/PUT /sigcodes/1.json
  def update

    sigcode_params[:language] = sigcode_params[:language].to_i
    sigcode_params[:frequency] = sigcode_params[:frequency].to_i

    respond_to do |format|
      if @sigcode.update(sigcode_params)
        format.html { redirect_to @sigcode, notice: 'Sigcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @sigcode }
      else
        format.html { render :edit }
        format.json { render json: @sigcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sigcodes/1
  # DELETE /sigcodes/1.json
  def destroy
    @sigcode.destroy
    respond_to do |format|
      format.html { redirect_to sigcodes_url, notice: 'Sigcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sigcode
      @sigcode = Sigcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sigcode_params
      params.require(:sigcode).permit(:company_id, :pharmacy_id, :sig_code, :active, :language, :expanded_text, :frequency)
    end
end
