class WidgetsController < ApplicationController

  layout 'profile'

  before_action :confirm_logged_in

  def index
  end

  def new

  end

  def create
    # initializes object to check validation and grab quantity attr
    @widget = Widget.new(widget_params)

    if @widget.valid? then
      @user = User.find(session[:user_id])
      @order = Order.new(:user_id => @user.id, :arrivalDt => 7.days.from_now)

      # creates new widget and adds to order
      for i in 1..@widget.quantity.to_i
        @widget = Widget.new(widget_params)
        @order.widgets << @widget
        @widget.save
      end

      if @order.valid? then
        @order.user_id = @user.id
        @order.save
      end

       @user.save

      flash[:notice] = @widget.quantity + " item(s) were successfully added to the order." + @order.user_id.to_s
      redirect_to(:controller => "widgets", :action => 'edit', :order_id => @order.id)

    else
      render('new')
    end
  end

  def edit
    @order = Order.find(params[:order_id])
    @widgets = @order.widgets.sorted
  end

  def update
    @order = Order.find(params[:order_id])

    # initializes object to get quantity attr
    @widget = Widget.new(widget_params)

    if @widget.valid? then

      # creates new widget and adds to order
      for i in 1..@widget.quantity.to_i
        @widget = Widget.new(widget_params)
        @order.widgets << @widget
        @widget.save
      end

      @order.save
      flash[:notice] = @widget.quantity + " item(s) were successfully added to the order."

      redirect_to(:controller => "widgets", :action => 'edit', :order_id => @order.id)
    else
      @widgets = @order.widgets.sorted
      render('edit')
    end
  end

  def destroy
    @order = Order.find(params[:order_id])
    @widget = @order.widgets.find(params[:widget_id])

    @widget.destroy
    @order.save

    flash[:notice] = "1 item(s) was successfully removed from the order."
    redirect_to(:controller => "widgets", :action => 'edit', :order_id => @order.id)
  end

  private
    def widget_params
      params.require(:widget).permit(:order_id, :wigtype, :color, :quantity, :created_at, :updated_at
        #state_tasks: [:budget, :location, :notes]
        )
    end


end
