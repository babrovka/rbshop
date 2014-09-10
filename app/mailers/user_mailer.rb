class UserMailer < ActionMailer::Base
  default from: 'robot@rbcos.ru'

  def welcome(user)
    @user = user

    mail to: user.email
  end
end
