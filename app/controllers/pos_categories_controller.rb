class PosCategoriesController < ApplicationController
  before_action :set_pos_category, only: [:show, :edit, :update, :destroy]


  def posCategory
    @pos_category = PosCategory.new
  end


  # GET /pos_categories
  # GET /pos_categories.json
  def index
    @pos_categories = PosCategory.all
  end

  # GET /pos_categories/1
  # GET /pos_categories/1.json
  def show
  end

  # GET /pos_categories/new
  def new
    @pos_category = PosCategory.new
  end

  # GET /pos_categories/1/edit
  def edit
  end

  def posCategory
    #testing
    @pos_category = PosCategory.new
  end

  # POST /pos_categories
  # POST /pos_categories.json
  def create
    @pos_category = PosCategory.new(pos_category_params)

    respond_to do |format|
      if @pos_category.save
        format.html { redirect_to @pos_category, notice: 'Pos category was successfully created.' }
        format.json { render :show, status: :created, location: @pos_category }
      else
        format.html { render :new }
        format.json { render json: @pos_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos_categories/1
  # PATCH/PUT /pos_categories/1.json
  def update
    respond_to do |format|
      if @pos_category.update(pos_category_params)
        format.html { redirect_to @pos_category, notice: 'Pos category was successfully updated.' }
        format.json { render :show, status: :ok, location: @pos_category }
      else
        format.html { render :edit }
        format.json { render json: @pos_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos_categories/1
  # DELETE /pos_categories/1.json
  def destroy
    @pos_category.destroy
    respond_to do |format|
      format.html { redirect_to pos_categories_url, notice: 'Pos category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pos_category
      @pos_category = PosCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pos_category_params
      params.require(:pos_category).permit(:dept_number, :category_abbreviation, :category_description, :taxable, :medical)
    end
end
