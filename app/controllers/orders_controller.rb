class OrdersController < ApplicationController

  layout 'profile'

  before_action :confirm_logged_in, :except => [:review] 

  # POST /users
  # POST /users.json

  def index
    if !session[:user_admin] then
      flash[:notice] = 'Admin only area!'
      redirect_to :controller => "access", :action => 'login'
    end
    @orders = Order.all
  end

  def new

  end

  def create
  end

  def edit
  	@order = Order.find(params[:order_id])
    @user = @order.user
    #@widgettype_options = WidgetType.all.map{|c| [ c.name, c.id ] }

    @widgets = @order.widgets
  end

  def update
    @order = Order.find(params[:order_id])

    if @order.update_attributes(order_params)
        @order.status = 'shipped'

        send_mailer

        flash[:notice] = "Confirmation email sent to " + @order.user.email + "!"
        @order.save
        redirect_to(:controller => "orders", :action => 'review', :order_id => @order.id)
    else
        @widgets = @order.widgets
        render 'edit' 
    end
  end

  def ed_stat
    @order = Order.find(params[:order_id])
  end

  def up_stat
    @order = Order.find(params[:order_id])

    if @order.update_attributes(order_params)
      #@order.save
      flash[:notice] = "Order successfully updated"
      redirect_to(:controller => "orders", :action => 'index')
    else
      flash[:notice] = "Whoops, we got issues.."
      render('ed_stat')
    end
    
  end

  def send_mailer
      UserMailer.welcome_email(@order).deliver
  end

  def review
      @order = Order.find(params[:order_id])
  end

  def delete
    @order = Order.find(params[:order_id])
  end

  def destroy
    @order = Order.find(params[:order_id])
    @order.destroy

    flash[:notice] = "Order deleted!"
    redirect_to(:controller => "widgets", :action => 'new')
  end

  private
    def order_params
      params.require(:order).permit(:arrivalDt, :status, :created_at, :updated_at )
    end
end
