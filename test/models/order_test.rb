require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	
	self.use_instantiated_fixtures = true

	test "should not save order without arrivalDt" do
  		order = Order.new()
  		assert_not order.save, "Saved the order without a arrival date field populated"
	end

	test "should not save order with less than seven days in the future" do
  		order = Order.new(:arrivalDt => '2016-06-06')
  		assert_not order.save, "Saved the order without less than seven days in the future"
	end

	test "should not save order with valid date format" do
  		order = Order.new(:arrivalDt => '2016-3306-06')
  		assert_not order.save, "Saved the order with bad date format"
	end

	test "should save order proper fields" do
  		order = Order.new(:arrivalDt => '2016-08-08')
  		assert order.save, "Saved the order without a arrival date field populated"
	end
end
