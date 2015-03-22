class CategoriesController < ApplicationController
  include CommonMethods

  before_action :ensure_that_signed_in
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_correct_user, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @income = Category.where user:current_user, income:true
    @outcome = Category.where user:current_user, income:false
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @entries = Entry.where category:@category
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    create_helper(@category)
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :income)
    end

    def ensure_that_correct_user
      redirect_to categories_path if current_user != @category.user
    end
end
