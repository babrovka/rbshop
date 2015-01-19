class UserMailer < ActionMailer::Base
  default from: 'robot@rbdis.ru'

  def welcome(user)
    @user = user

    mail to: user.email
  end
end
