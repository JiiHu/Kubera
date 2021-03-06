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
    @average = average_for_category(@category)
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
    update_helper(@category, category_params)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    class_name = @category.class.name
    @category.destroy
    destroy_helper(categories_url, class_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end


    def average_for_category(category)
      entries = Entry.where user:current_user, category:category
      avg = entries.average(:amount).to_f
      return avg.round(2)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :income)
    end

    def ensure_that_correct_user
      redirect_to categories_path if current_user != @category.user
    end
end
