class User < ActiveRecord::Base

	has_many :orders, inverse_of: :user, dependent: :destroy
  has_many :widgets, through: :orders, dependent: :destroy
  
	has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  FORBIDDEN_USERNAMES = ['admin']

  # shortcut validations, aka "sexy validations"
  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name,  :presence => true,
                         :length => { :maximum => 50 }
  validates :username, 	 :length => { :within => 8..25 },
                       	 :uniqueness => true
  validates :email, 		 :presence => true,
                    		 :length => { :maximum => 100 },
                    		 :format => EMAIL_REGEX,
                         :confirmation => true

	validate :username_is_allowed

	private

  	def username_is_allowed
    	if FORBIDDEN_USERNAMES.include?(username)
      		errors.add(:username, "has been restricted from use.")
    	end
  	end
end
