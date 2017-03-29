class UsersController < ApplicationController
 
  layout 'profile'

  def index
  end

  def new
  	@user = User.new(:isAdmin => false)
  end

  def create
  	@user = User.new(user_params)

  	if @user.save then
  		#session[:user_id => @user.username]
  		flash[:notice] = "Welcome to the club " + @user.first_name + "!" 
  		redirect_to(:controller => 'widgets', :action => 'new')
  	else
  		render('new')
  	end
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])

    if @user.update_attributes(user_params)
        flash[:notice] = "Successfully updated profile!"
        redirect_to(:controller => "widgets", :action => 'new')
    else
        flash[:notice] = "Uh Oh - we have an issue."
        render 'edit' 
    end
  end

  private
  def user_params
      params.require(:user).permit(:order_id, :username, :first_name, :last_name, 
      	:password, :password_confirmation, :email, :created_at, :updated_at
        )
    end
end
