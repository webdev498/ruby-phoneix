class AccountpostingsController < ApplicationController
  before_action :set_accountposting, only: [:show, :edit, :update, :destroy]

  # GET /accountpostings
  # GET /accountpostings.json
  def index
    @accountpostings = Accountposting.all
  end

  # GET /accountpostings/1
  # GET /accountpostings/1.json
  def show
  end

  # GET /accountpostings/new
  def new
    @accountposting = Accountposting.new
  end

  # GET /accountpostings/1/edit
  def edit
  end

  # POST /accountpostings
  # POST /accountpostings.json
  def create
    @accountposting = Accountposting.new(accountposting_params)

    respond_to do |format|
      if @accountposting.save
        format.html { redirect_to @accountposting, notice: 'Accountposting was successfully created.' }
        format.json { render :show, status: :created, location: @accountposting }
      else
        format.html { render :new }
        format.json { render json: @accountposting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accountpostings/1
  # PATCH/PUT /accountpostings/1.json
  def update
    respond_to do |format|
      if @accountposting.update(accountposting_params)
        format.html { redirect_to @accountposting, notice: 'Accountposting was successfully updated.' }
        format.json { render :show, status: :ok, location: @accountposting }
      else
        format.html { render :edit }
        format.json { render json: @accountposting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountpostings/1
  # DELETE /accountpostings/1.json
  def destroy
    @accountposting.destroy
    respond_to do |format|
      format.html { redirect_to accountpostings_url, notice: 'Accountposting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accountposting
      @accountposting = Accountposting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accountposting_params
      params.require(:accountposting).permit(:dept_number, :master_account_number, :account_number, :post_date, :post_ticket_number, :post_ticket_sequence, :post_payor_id_number, :post_source, :post_type, :post_description, :post_medical_amount, :post_non_medical_amount, :post_tax_amount)
    end
end
