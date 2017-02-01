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

  def get_ticket
    @pos_transaction = PosTransaction.find_by_ticket_number(params[:ticket_number])
    @totalpaid = @pos_transaction.primary_payment_amount.to_f + @pos_transaction.secondary_payment_amount.to_f
    @change_due = @pos_transaction.total_amount.to_f + @pos_transaction.total_tax.to_f - @totalpaid
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

  def delete_detail
    @transaction = PosTransaction.find(params[:transactionId])
    transactionid = @transaction.id
    @transaction.deleteDetail(params)
    @transaction = PosTransaction.find(transactionid) # reload with all the new totals

    @totalpaid = @transaction.primary_payment_amount.to_f + @transaction.secondary_payment_amount.to_f
    @change_due = @transaction.total_amount.to_f + @transaction.total_tax.to_f - @totalpaid
    render :partial => "details_list"
  end

# POST /pos_transactions/add_new_detail
  def add_new_detail
    pos_header_params
    params[:pos_header][:transaction_date] = Time.now() if params[:pos_header][:transaction_date].to_s == ""
    update_payment_types
    if params[:transactionId].nil? || params[:transactionId] == ""
      @transaction = PosTransaction.create(pos_header_params)
    else
      @transaction = PosTransaction.find(params[:transactionId])
      @transaction.update(pos_header_params)
      @transaction.save!
    end
    transactionid = @transaction.id
    @transaction.addNewDetail(params)
    @transaction = PosTransaction.find(transactionid) # reload with all the new totals

    @totalpaid = @transaction.primary_payment_amount.to_f + @transaction.secondary_payment_amount.to_f
    @change_due = @transaction.total_amount.to_f + @transaction.total_tax.to_f - @totalpaid
    render :partial => "details_list"
  end


  def create_or_update
    pos_header_params
    params[:pos_header][:transaction_date] = Time.now() if params[:pos_header][:transaction_date].to_s == ""
    update_payment_types
    if params[:transactionId].nil? || params[:transactionId] == ""
      @transaction = PosTransaction.create(pos_header_params)
    else
      @transaction = PosTransaction.find(params[:transactionId])
      @transaction.update(pos_header_params)
      @transaction.save!
    end
    render :json => {status: "ok"}
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
    @totalpaid = @pos_transaction.primary_payment_amount.to_f + @pos_transaction.secondary_payment_amount.to_f
    @change_due = @pos_transaction.total_amount.to_f + @pos_transaction.total_tax.to_f - @totalpaid
  end

# Never trust parameters from the scary internet, only allow the white list through.
    def pos_transaction_params
      params.require(:pos_transaction).permit(:company_id, :pharmacy_id, :customer_id, :transaction_date, :ticket_number, :legacy_customer_id_number, :initials, :register_number, :account_number, :posted_flag, :any_flex_spending_items, :number_items, :primary_payment_method, :primary_payment_amount, :secondary_payment_method, :secondary_payment_amount, :total_amount, :total_tax, :medical_amount, :medical_tax, :medical_total, :non_medical_amount, :non_medical_tax, :non_medical_total)
    end

    def update_payment_types
      params[:pos_header][:primary_payment_method] = PosTransaction.payment_method_enum_to_string(params[:pos_header][:primary_payment_method]) if params[:pos_header][:primary_payment_method]
      params[:pos_header][:secondary_payment_method] = PosTransaction.payment_method_enum_to_string(params[:pos_header][:secondary_payment_method]) if params[:pos_header][:secondary_payment_method]
    end

end
