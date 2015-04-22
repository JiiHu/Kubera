class Entry < ActiveRecord::Base

	validates_presence_of :date
	validates_presence_of :amount
	validates_presence_of :category_id
	validates_presence_of :user_id

	validates :amount, :numericality => true, :allow_nil => true
	validates :category_id, :numericality => true, :allow_nil => true
	validates :user_id, :numericality => true, :allow_nil => true

	belongs_to :user
	belongs_to :category

end
