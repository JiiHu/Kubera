class Category < ActiveRecord::Base

  validates :name, length: { minimum: 3, maximum: 15 }
  validates_uniqueness_of :name, scope: :user
  
  belongs_to :user
  has_many :entries

  def to_s
    "#{name}"
  end
end
