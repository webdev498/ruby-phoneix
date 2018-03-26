class PricebreaksController < ApplicationController
  before_action :set_pricebreak, only: [:show, :edit, :update, :destroy]

  # GET /pricebreaks
  # GET /pricebreaks.json
  def index
    @pricebreaks = Pricebreak.all
  end

  # GET /pricebreaks/1
  # GET /pricebreaks/1.json
  def show
  end

  # GET /pricebreaks/new
  def new
    @pricebreak = Pricebreak.new
  end

  # GET /pricebreaks/1/edit
  def edit
  end

  # POST /pricebreaks
  # POST /pricebreaks.json
  def create
    @pricebreak = Pricebreak.new(pricebreak_params)

    respond_to do |format|
      if @pricebreak.save
        format.html { redirect_to @pricebreak, notice: 'Pricebreak was successfully created.' }
        format.json { render :show, status: :created, location: @pricebreak }
      else
        format.html { render :new }
        format.json { render json: @pricebreak.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pricebreaks/1
  # PATCH/PUT /pricebreaks/1.json
  def update
    respond_to do |format|
      if @pricebreak.update(pricebreak_params)
        format.html { redirect_to @pricebreak, notice: 'Pricebreak was successfully updated.' }
        format.json { render :show, status: :ok, location: @pricebreak }
      else
        format.html { render :edit }
        format.json { render json: @pricebreak.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pricebreaks/1
  # DELETE /pricebreaks/1.json
  def destroy
    @pricebreak.destroy
    respond_to do |format|
      format.html { redirect_to pricebreaks_url, notice: 'Pricebreak was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pricebreak
      @pricebreak = Pricebreak.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pricebreak_params
      params.require(:pricebreak).permit(:dept_number, :schedule_number, :pct_or_amount, :break_limit, :markup_pct, :markup_amount)
    end
end
