require 'test_helper'

class WidgetTest < ActiveSupport::TestCase

	self.use_instantiated_fixtures = true

	test "should not save widget without color" do
  		widget = Widget.new(:wigtype => 'Widget', :quantity => 1)
  		assert_not widget.save, "Saved the widget without a color present"
	end

	test "should not save widget without wigtype" do
  		widget = Widget.new(:color => 'red', :quantity => 1)
  		assert_not widget.save, "Saved the widget without a type present"
	end

	test "should not save widget without quantity" do
  		widget = Widget.new(:wigtype => 'Widget', :color => 'red')
  		assert_not widget.save, "Saved the widget without a quantity present"
	end

	test "should not save widget with alpha text in quantity field" do
  		widget = Widget.new(:color => 'red', :wigtype => 'Widget', :quantity => 'alpha')
  		assert_not widget.save, "Saved the widget with alpha quantity field"
	end
	test "should not save widget with decimal in quantity field" do
  		widget = Widget.new(:color => 'red', :wigtype => 'Widget', :quantity => 2.2)
  		assert_not widget.save, "Saved the widget with decimal in quantity field"
	end

	test "should not save widget with invalid color" do
  		widget = Widget.new(:color => 'indigo', :wigtype => 'Widget', :quantity => 'alpha')
  		assert_not widget.save, "Saved the widget with invalid color value"
	end

	test "should not save widget with invalid widget type" do
  		widget = Widget.new(:color => 'red', :wigtype => 'Widget Extreme', :quantity => 'alpha')
  		assert_not widget.save, "Saved the widget with invalid type value"
	end

	test "should save widget with proper values" do
  		widget = Widget.new(:color => 'red', :wigtype => 'Widget', :quantity => 1)
  		assert widget.save, "Did not save the widget with proper values"
	end

	test "should add widget to order" do
		order = Order.new(:arrivalDt => @order_one.arrivalDt)
  		widget = Widget.new(:order_id => @order_one.id, :color => 'red', :wigtype => 'Widget', :quantity => 1)

  		assert widget.save, "Did not add the widget with proper values"
  		assert order.save, "Did not save the order with proper values"
	end



end
