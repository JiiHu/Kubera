class User < ActiveRecord::Base

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
	
  has_secure_password
  has_many :categories, dependent: :destroy 
  
  def to_s
    "#{username}"
  end

end
