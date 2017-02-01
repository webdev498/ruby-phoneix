class PosTaxesController < ApplicationController
  before_action :set_pos_tax, only: [:show, :edit, :update, :destroy]

  # GET /pos_taxes
  # GET /pos_taxes.json
  def index
    @pos_taxes = PosTax.all
  end

  # GET /pos_taxes/1
  # GET /pos_taxes/1.json
  def show
  end

  # GET /pos_taxes/new
  def new
    @pos_tax = PosTax.new
  end

  # GET /pos_taxes/1/edit
  def edit
  end

  # POST /pos_taxes
  # POST /pos_taxes.json
  def create
    @pos_tax = PosTax.new(pos_tax_params)

    respond_to do |format|
      if @pos_tax.save
        format.html { redirect_to @pos_tax, notice: 'Pos tax was successfully created.' }
        format.json { render :show, status: :created, location: @pos_tax }
      else
        format.html { render :new }
        format.json { render json: @pos_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos_taxes/1
  # PATCH/PUT /pos_taxes/1.json
  def update
    respond_to do |format|
      if @pos_tax.update(pos_tax_params)
        format.html { redirect_to @pos_tax, notice: 'Pos tax was successfully updated.' }
        format.json { render :show, status: :ok, location: @pos_tax }
      else
        format.html { render :edit }
        format.json { render json: @pos_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos_taxes/1
  # DELETE /pos_taxes/1.json
  def destroy
    @pos_tax.destroy
    respond_to do |format|
      format.html { redirect_to pos_taxes_url, notice: 'Pos tax was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_tax
      @pos_tax = PosTax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pos_tax_params
      params.require(:pos_tax).permit(:company_id, :pharmacy_id, :tax_code, :tax_description, :tax_rate)
    end
end
