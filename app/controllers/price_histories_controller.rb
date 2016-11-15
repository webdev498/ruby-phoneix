class PriceHistoriesController < ApplicationController
  before_action :set_price_history, only: [:show, :edit, :update, :destroy]

  # GET /price_histories
  # GET /price_histories.json
  def index
    @price_histories = PriceHistory.all
  end

  # GET /price_histories/1
  # GET /price_histories/1.json
  def show
  end

  # GET /price_histories/new
  def new
    @price_history = PriceHistory.new
  end

  # GET /price_histories/1/edit
  def edit
  end

  # POST /price_histories
  # POST /price_histories.json
  def create
    @price_history = PriceHistory.new(price_history_params)

    respond_to do |format|
      if @price_history.save
        format.html { redirect_to @price_history, notice: 'Price history was successfully created.' }
        format.json { render :show, status: :created, location: @price_history }
      else
        format.html { render :new }
        format.json { render json: @price_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_histories/1
  # PATCH/PUT /price_histories/1.json
  def update
    respond_to do |format|
      if @price_history.update(price_history_params)
        format.html { redirect_to @price_history, notice: 'Price history was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_history }
      else
        format.html { render :edit }
        format.json { render json: @price_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_histories/1
  # DELETE /price_histories/1.json
  def destroy
    @price_history.destroy
    respond_to do |format|
      format.html { redirect_to price_histories_url, notice: 'Price history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_history
      @price_history = PriceHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_history_params
      params.require(:price_history).permit(:dept_number, :employee_id_number, :mode, :mechanism, :source, :element_changed, :old_price, :new_price)
    end
end
