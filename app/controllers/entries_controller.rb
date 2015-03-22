class EntriesController < ApplicationController
  include CommonMethods

  before_action :ensure_that_signed_in
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_correct_user, only: [:show, :edit, :update, :destroy]

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
    respond_to do |format|
      category = Category.find entry_params['category_id']
      if category.user == current_user and @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
