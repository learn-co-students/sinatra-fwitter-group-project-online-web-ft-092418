class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true

  def slug
    #taken off stack overflow
    slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(str)
    name = str.gsub("-", " ")
    User.find_by_username(name)
  end


end
