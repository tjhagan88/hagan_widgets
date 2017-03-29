class Order < ActiveRecord::Base

	has_many :widgets, dependent: :destroy
	belongs_to :user

	# Validation Variables
	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	# Validation Methods
    validates_presence_of :arrivalDt
    validates_datetime :arrivalDt, :after => 6.days.from_now

end
