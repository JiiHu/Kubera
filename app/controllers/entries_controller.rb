class EntriesController < ApplicationController
  include CommonMethods

  before_action :ensure_that_signed_in
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_correct_user, only: [:show, :edit, :update, :destroy]
  before_action :categories_to_form, only: [:new, :edit, :create]

  def view
    @year = params[:year]
    @month = params[:month]

    @entries = Entry.all
  end


  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.where user:current_user
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.user = current_user

    create_helper(@entry)
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    update_helper(@entry, entry_params)
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    class_name = @entry.class.name
    @entry.destroy
    destroy_helper(entries_url, class_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:amount, :date, :category_id)
    end

    def ensure_that_correct_user
      redirect_to entries_path if current_user != @entry.user
    end

    def is_category_current_users_category
      return false unless @entry.category
      return @entry.category.user == current_user
    end

    def categories_to_form
      @categories = Category.where user:current_user
    end
end
