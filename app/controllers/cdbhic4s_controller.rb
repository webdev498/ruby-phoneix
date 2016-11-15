class Cdbhic4sController < ApplicationController
  before_action :set_cdbhic4, only: [:show, :edit, :update, :destroy]

  # GET /cdbhic4s
  # GET /cdbhic4s.json
  def index
    @cdbhic4s = Cdbhic4.all
  end

  # GET /cdbhic4s/1
  # GET /cdbhic4s/1.json
  def show
  end

  # GET /cdbhic4s/new
  def new
    @cdbhic4 = Cdbhic4.new
  end

  # GET /cdbhic4s/1/edit
  def edit
  end

  # POST /cdbhic4s
  # POST /cdbhic4s.json
  def create
    @cdbhic4 = Cdbhic4.new(cdbhic4_params)

    respond_to do |format|
      if @cdbhic4.save
        format.html { redirect_to @cdbhic4, notice: 'Cdbhic4 was successfully created.' }
        format.json { render :show, status: :created, location: @cdbhic4 }
      else
        format.html { render :new }
        format.json { render json: @cdbhic4.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cdbhic4s/1
  # PATCH/PUT /cdbhic4s/1.json
  def update
    respond_to do |format|
      if @cdbhic4.update(cdbhic4_params)
        format.html { redirect_to @cdbhic4, notice: 'Cdbhic4 was successfully updated.' }
        format.json { render :show, status: :ok, location: @cdbhic4 }
      else
        format.html { render :edit }
        format.json { render json: @cdbhic4.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cdbhic4s/1
  # DELETE /cdbhic4s/1.json
  def destroy
    @cdbhic4.destroy
    respond_to do |format|
      format.html { redirect_to cdbhic4s_url, notice: 'Cdbhic4 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cdbhic4
      @cdbhic4 = Cdbhic4.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cdbhic4_params
      params.require(:cdbhic4).permit(:hic4_sequence_number, :hic4_description, :hic4_root, :hic4_hic, :hic4_salt)
    end
end
