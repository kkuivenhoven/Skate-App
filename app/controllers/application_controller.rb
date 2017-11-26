class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
	before_action :on_mobile?

	def on_mobile?
		if session[:mobile_param]
			session[:mobile_param] == "1"
		else
			# request.user_agent =~ /Mobile|webOS/
			request.user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i
		end
		flash[:danger] = "request.user_agent is: #{request.user_agent}"
		flash[:info] = "request.user_agent is: #{request.user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i}"
		flash[:success] = "session[:mobile_param] is: #{session[:mobile_param]}"
	end

  private
   
     # confirms a logged-in user
     def logged_in_user
       unless logged_in?
         store_location
         flash[:danger] = "Please log in."
         redirect_to login_url
       end
     end

end
