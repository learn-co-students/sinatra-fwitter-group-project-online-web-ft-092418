class User < ActiveRecord::Base

  has_many :tweets
  has_secure_password


  def slug
     slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)

    found = self.all.map {|user|
      user if user.slug == slug}.first
  end
end
