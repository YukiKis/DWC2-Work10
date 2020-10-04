class Batch::SendMail
  def self.send_daily_mail
    User.all.each do |user|
      NotificationMailer.daily_mail(user).deliver_now
    end
    p "Finish sending daily mails" 
  end
end
