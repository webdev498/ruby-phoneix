class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def account
  	@account = Account.new
  end


  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
    @account = @accounts.first
    @account_records = @account.postings_since
    @account_postings_page_number = 1
    @account_postings_total_pages = (@account.total_posting_count_since(nil,params[:transaction_type]) / 9 ) == 0 ? 1 : (@account.total_posting_count_since(nil,params[:transaction_type]) / 9 )
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  def show_by_account_number
    @account = Account.where({account_number: params[:id].to_i}).first
    if(@account.nil?)
      @account = Account.new
      @account_records = []
      @account_postings_page_number = 1
      @account_postings_total_pages = 1
    else
      @account_records = @account.postings_since
      @account_postings_page_number = 1
      @account_postings_total_pages = (@account.total_posting_count_since(nil,params[:transaction_type])  / 9 ) == 0 ? 1 : (@account.total_posting_count_since(nil,params[:transaction_type]) / 9 )
    end
    render 'show'
  end
  # GET /accounts/new
  def new
    @account = Account.new
    @account_records = []
    @account_postings_page_number = 1
    @account_postings_total_pages = 1
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create

    accountParams[:accounting_method] = accountParams[:accounting_method].to_i
    accountParams[:payor_type] = accountParams[:payor_type].to_i
    accountParams[:print_statement] = accountParams[:print_statement].to_i
    accountParams[:rx_charge_description] = accountParams[:rx_charge_description].to_i
    accountParams[:statement_type] = accountParams[:statement_type].to_i

    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    accountParams[:accounting_method] = accountParams[:accounting_method].to_i
    accountParams[:payor_type] = accountParams[:payor_type].to_i
    accountParams[:print_statement] = accountParams[:print_statement].to_i
    accountParams[:rx_charge_description] = accountParams[:rx_charge_description].to_i
    accountParams[:statement_type] = accountParams[:statement_type].to_i

    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def next_accounts
    @searchCustomers = Account.next_account params[:start], params[:page], 9


    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
    searchTemplate = render_to_string partial: 'common/search/account_search_modal_template', locals: { searchCustomers: @searchCustomers }, :layout => false

    # when using the technique above, the newlines (\n) have to be removed
    render js: "$('#account_search_modal_partial').html(\'" + searchTemplate.gsub("\n","") + '\');'

  end

  def next_account_postings
    @account = Account.where({account_number: params[:account_number]}).first
    @account_postings_page_number = params[:page].nil? ? 1 : params[:page].to_i
    @account_records = @account.postings_since params[:transactions_since], params[:transaction_type], @account_postings_page_number
    @account_postings_total_pages = (@account.total_posting_count_since(params[:transactions_since],params[:transaction_type]) / 9 ) == 0 ? 1 : (@account.total_posting_count_since(params[:transactions_since],params[:transaction_type]) / 9 )
    searchTemplate = render_to_string :layout => false,
                                      :partial => 'accounts/next_account_postings',
                                      locals: {
                                          account: @account,
                                          account_records: @account_records,
                                          account_postings_total_pages: @account_postings_total_pages,
                                          account_postings_page_number: @account_postings_page_number
                                      }


    # technique below eliminates the extra .js file used in the ajax response.   it trades off the disk access for the \n replacement below
    # remember, its not quite a standard rails approach
    # searchTemplate = render_to_string partial: 'common/search/account_search_modal_template', locals: { searchCustomers: @searchCustomers }, :layout => false

    # when using the technique above, the newlines (\n) have to be removed
      render js: "$('#account_postings').html(\'" + searchTemplate.gsub("\n","") + '\');'

  end

  def account_postings
    @account = Account.where({account_number: params[:account_number]}).first
    @account_records = @account.postings_since(params[:transactions_since], params[:transaction_type])
    @account_postings_page_number = params[:page] || 1
    @account_postings_total_pages = (@account.total_posting_count_since(params[:transactions_since], params[:transaction_type]) / 9 ) == 0 ? 1 : (@account.total_posting_count_since(params[:transactions_since],params[:transaction_type]) / 9 )
    render :layout => false, :template => 'accounts/_next_account_postings'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
      if @account
        @account_records =  @account.postings_since
        @account_postings_page_number = 1
        @account_postings_total_pages = (@account.total_posting_count_since / 9 ) == 0 ? 1 : (@account.total_posting_count_since / 9 )
      else
        @account_records = []
        @account_postings_page_number = 1
        @account_postings_total_pages = 1
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:company_id, :pharmacy_id, :plan_id_code, :facility_id, :account_payor_id, :account_sponsor_id, :account_number, :master_account_number, :accounting_method, :payor_type, :legacy_customer_id_number, :legacy_sponsor_id_number, :allow_otc_charges, :active, :print_statement, :date_opened, :last_statement_date, :last_charge_date, :last_payment_date, :last_past_due_date, :past_due_letter_sent, :current_period_amount, :last_period_amount, :high_balance_amount, :high_past_due_amount, :over_30_amount, :over_60_amount, :over_90_amount, :number_times_past_30, :number_times_past_60, :number_times_past_90, :last_charge_amount, :last_payment_amount, :last_statement_balance, :tax_deductible_amount_year_to_date, :non_deductible_amount_year_to_date, :finance_charges_year_to_date, :tax_paid_year_to_date, :credit_limit, :finance_charge_percentage1, :finance_charge_percentage2, :finance_percentage1_limit, :terms_rate, :terms_amount, :memo, :notes, :rx_charge_description, :statement_type)
    end
end
