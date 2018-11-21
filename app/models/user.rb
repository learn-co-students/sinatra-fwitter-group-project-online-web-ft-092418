class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password

    validates :username, :email, presence: true

    # def slug 
    #     self.id
    # end

    def slug 
        sloog = self.username.gsub(" ", "-").downcase
    end

    def self.find_by_slug(sloog)
        unsloog = sloog.gsub("-", " ")
        self.find_by(username: unsloog)
    end
end