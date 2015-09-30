class UserMailer < ActionMailer::Base
  default from: "admin@rottenmangoes.com"

  def notify_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your email has been deleted')
  end
end
