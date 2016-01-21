#Resources: https://www.railstutorial.org/book/account_activation_password_reset

class AccountActivationsController < ApplicationController

#this function takes the email address that is in the params hashand and authenticates that user that belongs to that email address
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
