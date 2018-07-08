#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014
#Note: this Sessions Controller comes from https://www.railstutorial.org/book/log_in_log_out

class SessionsController < ApplicationController
	require 'firebase'

  #starts a new login session
  def new
		firebase_url = 'https://skatespots-3a8f0.firebaseio.com'
		firebase_secret = 'yZGqkNt8sd5en5F2ICXDqo2lhUgVqXbVuLEk8QbG'
		firebase = Firebase::Client.new(firebase_url, firebase_secret)
  end

  #creates a new login session with the email and password, makes sure that the user is activated first
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. "
        message += " Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #if the user logs out, destroys the current session
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
