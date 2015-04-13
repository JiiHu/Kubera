class EntriesController < ApplicationController
  include CommonMethods

  before_action :ensure_that_signed_in
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_correct_user, only: [:show, :edit, :update, :destroy]
  before_action :current_users_categories, only: [:new, :edit, :create]
  before_action :categories_is_not_empty, only: [:new]

  def view
    @year = params[:year].to_i
    @month = params[:month].to_i

    @entries = Entry.where(date: Date.new(@year, @month).all_month, user:current_user)
    @categories = stats_from_entries(@entries)
  end


  def stats
    @total_stats = stats_from_entries(Entry.where user:current_user)
    @lines_income = []

    generate_chart_data_from_all_categories
  end


  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.where user:current_user
    @views = list_month_urls
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

    def current_users_categories
      @categories = Category.where user:current_user
    end

    def generate_chart_data_from_all_categories  
      oldest = users_oldest_entrys_date
  
      Category.where(user:current_user).each do |c|
        date = users_newest_entrys_date
        list = {}

        go_through_all_entries_on_category(c, date, oldest, list)
        
        chart = {}
        chart['name'] = c.name
        chart['data'] = list

        @lines_income << chart
      end
    end

    def go_through_all_entries_on_category(category, date, oldest, list)
      while date >= (oldest - 1.month)
        list[date] = 0

        entries = Entry.where(category:category, date: Date.new(date.year, date.month).all_month, user:current_user)
        entries.each do |e|
          list[date] += e.amount.to_f
        end

        date = date - 1.month
      end
    end

    def stats_from_entries(entries)
      stats, stats['income'], stats['outcome'] = {}, {}, {}

      stats['income']['Total'], stats['outcome']['Total'] = 0, 0
      Category.where(user:current_user).each do |c|
        in_out = c.income? ? 'income' : 'outcome'
        stats[in_out][c] = 0 if stats[in_out][c].nil?

        total = total_from_categories(entries.where category:c)
        stats[in_out][c] += total
        stats[in_out]['Total'] += total
      end
      return stats
    end

    def total_from_categories(entries)
      total = 0
      entries.each do |e|
        total += e.amount
      end
      return total
    end

    def list_month_urls
      return {} if Entry.where(user:current_user).empty?
      oldest = users_oldest_entrys_date
      date = users_newest_entrys_date

      prefix = '/entries/'

      list = {}
      while date >= oldest - 1.month
        month = date.month
        year = date.year.to_s
        tag = year + ' ' + Date::MONTHNAMES[month]
        url = prefix + year + '/' + month.to_s
        list[tag] = url
        date = date - 1.month
      end
      
      return list
    end

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

    def categories_is_not_empty
      alert = "You must create a category before creating a new entry"
      redirect_to new_category_path, alert: alert if Category.where(user:current_user).empty?
    end

    def is_category_current_users_category
      return false unless @entry.category
      return @entry.category.user == current_user
    end

    def users_oldest_entrys_date
      Entry.where(user:current_user).order('date DESC').last.date
    end

    def users_newest_entrys_date
      newest = Entry.where(user:current_user).order('date DESC').first.date
      return newest if Date.today < newest
      Date.today
    end

end
