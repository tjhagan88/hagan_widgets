require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	self.use_instantiated_fixtures = true

	test "should not save user without email" do
  		user = User.new(username: 'seany_c', first_name: "Sean", last_name: "Connery", 
  						password_digest: "password")

  		assert_not user.save, "Saved new user without email field populated"
	end

	test "should not save user invalid email field" do
  		user = User.new()
  		user.username = 'username_test'
  		user.first_name = 'Gary'
  		user.last_name = 'Coleman'
  		user.password = 'password123'
  		user.password_confirmation = 'password123'
  		user.email = 'example.com'

  		assert_not user.save, "Save new user with invalid email address"
	end

	test "should not save user mismatching password fields" do
  		user = User.new()
  		user.username = 'username_test'
  		user.first_name = 'Gary'
  		user.last_name = 'Coleman'
  		user.password = 'password123'
  		user.password_confirmation = 'password12'
  		user.email = 'example.com'

  		assert_not user.save, "Save new user with mismatching passwords"
	end

	test "should not save user with invalid email" do
  		user = User.new()
  		user.username = 'username_test'
  		user.first_name = 'Gary'
  		user.last_name = 'Coleman'
  		user.password = 'password123'
  		user.password_confirmation = 'password123'
  		user.email = 'example@gmail.com'

  		assert user.save, "Did not save new user with valid fields"
	end


	test "should save user with proper fields" do
  		assert @user_one.save, "Saved new user with valid fields"
	end
end
