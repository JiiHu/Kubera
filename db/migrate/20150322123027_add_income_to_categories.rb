class AddIncomeToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :income, :boolean, default: false

  	Category.all.each do |c|
  		c.update_attribute(:income, false)
  	end

  end
end
