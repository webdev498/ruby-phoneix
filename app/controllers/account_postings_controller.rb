class AccountPostingsController < ApplicationController
  before_action :set_account_posting, only: [:show, :edit, :update, :destroy]

  # GET /account_postings
  # GET /account_postings.json
  def index
    @account_postings = AccountPosting.all
  end

  # GET /account_postings/1
  # GET /account_postings/1.json
  def show
  end

  # GET /account_postings/new
  def new
    @account_posting = AccountPosting.new
  end

  # GET /account_postings/1/edit
  def edit
  end

  # POST /account_postings
  # POST /account_postings.json
  def create

    account_posting.post_source = account_posting.post_source.to_i
    account_posting.post_type = account_posting.post_type.to_i

    @account_posting = AccountPosting.new(account_posting_params)

    respond_to do |format|
      if @account_posting.save
        format.html { redirect_to @account_posting, notice: 'Account posting was successfully created.' }
        format.json { render :show, status: :created, location: @account_posting }
      else
        format.html { render :new }
        format.json { render json: @account_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_postings/1
  # PATCH/PUT /account_postings/1.json
  def update

    account_posting.post_source = account_posting.post_source.to_i
    account_posting.post_type = account_posting.post_type.to_i

    respond_to do |format|
      if @account_posting.update(account_posting_params)
        format.html { redirect_to @account_posting, notice: 'Account posting was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_posting }
      else
        format.html { render :edit }
        format.json { render json: @account_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_postings/1
  # DELETE /account_postings/1.json
  def destroy
    @account_posting.destroy
    respond_to do |format|
      format.html { redirect_to account_postings_url, notice: 'Account posting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_posting
      @account_posting = AccountPosting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_posting_params
      params.require(:account_posting).permit(:company_id, :pharmacy_id, :account_id, :master_account_number, :account_number, :post_date, :post_ticket, :post_ticket_sequence, :post_payor_id, :post_source, :post_type, :post_description, :post_medical_amount, :post_non_medical_amount, :post_tax_amount)
    end
end
