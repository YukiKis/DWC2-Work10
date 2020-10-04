class NotificationMailer < ApplicationMailer
  default from: "no-replay@gmail.com"

  def complete_mail(user)
    @user = user
    mail(subject: "Complete join your address", to: @user.email)
  end
  
  def daily_mail(user)
    @user = user
    mail(subject: "Daily Mail", to: @user.email)
  end
end
