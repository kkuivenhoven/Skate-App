class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
	before_action :user_on_mobile?


  private

			MOBILE_BROWSERS = ["playbook", "windows phone", "android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

		def user_on_mobile?
			type = request.user_agent.downcase
			MOBILE_BROWSERS.each do |m|
				if type.match(m)
					session[:mobile_param] = 1
				else
					session[:mobile_param] = 0
				end
			end
		end


     # confirms a logged-in user
     # https://www.railstutorial.org/book, Hartl Michael, 2014
     def logged_in_user
       unless logged_in?
         store_location
         flash[:danger] = "Please log in."
         redirect_to login_url
       end
     end

end
