class PosTransactionsController < ApplicationController
  before_action :set_pos_header, only: [:show, :edit, :update, :destroy, :view]

# 	def point_of_sale
# #		@pos = PosTransaction.new
#         @pos = PosTransaction.find 18
# 	end


  # GET /pos_headers/1
  # GET /pos_headers/1.json
  def show
      render :edit
  end

  def view
    respond_to do |format|
      format.html { render :edit }
      format.json { render :json => @pos_transaction }
    end
  end

  # GET /pos_headers/new
  def new
    @pos_transaction = PosTransaction.new
  end

# POST /pos_transactions/add_new_detail
  def add_new_detail
    @transaction = params[:transactionId].nil? || params[:transactionId] == "" ? PosTransaction.create(pos_header_params) : PosTransaction.find(params[:transactionId])
    @transaction.addNewDetail(params)
    render :partial => "details_list"
  end


  # GET /pos_headers/1/edit
  def edit
  end


  # POST /pos_headers
  # POST /pos_headers.json
  def create
    @pos_transaction = PosTransaction.new(pos_header_params)

    respond_to do |format|
      if @pos_transaction.save
        format.html { redirect_to @pos_transaction, notice: 'Pos header was successfully created.' }
        format.json { render :show, status: :created, location: @pos_transaction }
      else
        format.html { render :new }
        format.json { render json: @pos_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos_headers/1
  # PATCH/PUT /pos_headers/1.json
  def update
    respond_to do |format|
      if @pos_transaction.update(pos_header_params)
        format.html { redirect_to @pos_transaction, notice: 'Pos header was successfully updated.' }
        format.json { render :show, status: :ok, location: @pos_transaction }
      else
        format.html { render :edit }
        format.json { render json: @pos_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos_headers/1
  # DELETE /pos_headers/1.json
  def destroy
    @pos_transaction.destroy
    respond_to do |format|
      format.html { redirect_to pos_headers_url, notice: 'Pos header was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_header
      @pos_transaction = PosTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pos_header_params
      params.require(:pos_header).permit(:dept_number, :pos_transaction_date, :pos_ticket_number, :rna_customer_id_number, :initials, :register_number, :account_number, :posted_flag, :any_flex_spending_items, :number_items, :primary_payment_method, :primary_payment_amount, :secondary_payment_method, :secondary_payment_amount, :tertiary_payment_method, :tertiary_payment_amount, :total_amount, :total_tax, :medical_amount, :medical_tax, :medical_total, :non_medical_amount, :non_medical_tax, :non_medical_total)
    end
end
