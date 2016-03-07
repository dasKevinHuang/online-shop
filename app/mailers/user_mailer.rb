class UserMailer < ApplicationMailer
  def contact_email(email)
    @email = email
    mail(from: "\"The Shop\" <#{ENV['gmail_username']}>",
         to: @email,
         subject: 'Welcome to our shop!') do |format|
      format.html { render 'welcome_email'}
      format.text { render 'welcome_email'}
         end
  end

  def order_email(email, order_id)
    @email = email
    @order = Order.find(order_id)
    mail(from: "\"The Shop\" <#{ENV['gmail_username']}>",
         to: @email,
         subject: "Your Shoppe Order Confirmation - Order \##{@order.id}") do |format|
      format.html { render 'order_email'}
      format.text { render 'order_email'}
         end
  end
end
