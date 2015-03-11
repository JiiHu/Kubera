class Category < ActiveRecord::Base

  validates :name, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }
  
  belongs_to :user

  def to_s
    "#{name}"
  end
end
