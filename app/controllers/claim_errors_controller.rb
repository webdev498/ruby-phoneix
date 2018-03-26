class ClaimErrorsController < ApplicationController
  before_action :set_claim_error, only: [:show, :edit, :update, :destroy]

  # GET /claim_errors
  # GET /claim_errors.json
  def index
    @claim_errors = ClaimError.all
  end

  # GET /claim_errors/1
  # GET /claim_errors/1.json
  def show
  end

  # GET /claim_errors/new
  def new
    @claim_error = ClaimError.new
  end

  # GET /claim_errors/1/edit
  def edit
  end

  def claimError
    #testing
    @claimerror = ClaimError.new
  end

  # POST /claim_errors
  # POST /claim_errors.json
  def create

    claim_error_params[:error_type] = claim_error_params[:error_type].to_i
  
    @claim_error = ClaimError.new(claim_error_params)

    respond_to do |format|
      if @claim_error.save
        format.html { redirect_to @claim_error, notice: 'Claim error was successfully created.' }
        format.json { render :show, status: :created, location: @claim_error }
      else
        format.html { render :new }
        format.json { render json: @claim_error.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_errors/1
  # PATCH/PUT /claim_errors/1.json
  def update

    claim_error_params[:error_type] = claim_error_params[:error_type].to_i

    respond_to do |format|
      if @claim_error.update(claim_error_params)
        format.html { redirect_to @claim_error, notice: 'Claim error was successfully updated.' }
        format.json { render :show, status: :ok, location: @claim_error }
      else
        format.html { render :edit }
        format.json { render json: @claim_error.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_errors/1
  # DELETE /claim_errors/1.json
  def destroy
    @claim_error.destroy
    respond_to do |format|
      format.html { redirect_to claim_errors_url, notice: 'Claim error was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_error
      @claim_error = ClaimError.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_error_params
      params.require(:claim_error).permit(:dept_number, :error_type, :error_code, :error_text)
    end
end
