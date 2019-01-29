class User < ActiveRecord::Base
    has_many :tweets
    # validates :username, presence: true
    # validates :email, presence: true
    # validates :password, presence: true 
    
    has_secure_password

    def slug
        username.parameterize
    end

    def self.find_by_slug(slug)
        # is there a better way to do this?
        self.all.detect {|i| i.username.parameterize == slug}
    end
end