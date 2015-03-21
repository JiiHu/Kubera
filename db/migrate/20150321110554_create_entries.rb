class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.decimal :amount
      t.date :date
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
