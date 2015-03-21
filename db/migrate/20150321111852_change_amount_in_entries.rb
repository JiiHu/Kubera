class ChangeAmountInEntries < ActiveRecord::Migration
  def change
  	change_column :entries, :amount, :decimal, precision: 8, scale: 2
  end
end
