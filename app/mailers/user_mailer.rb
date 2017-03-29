class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email(order)
    @user = order.user
    @order = order

    @url  = 'http://' + @url_host + '/orders/review?order_id=' + @order.id.to_s
    mail(to: @user.email, subject: 'Recent Widget Factory Purchase')
  end
end
