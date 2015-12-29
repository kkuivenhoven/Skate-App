#Sources:
#https://www.railstutorial.org/book, Hartl Michael, 2014

class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate account"
  end

  def password_reset(user)
#    if @user != nil
      @user = user
      mail to: user.email, subject: "Password reset"
#    end
  end

end
