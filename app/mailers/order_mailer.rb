class OrderMailer < ActionMailer::Base
  default from: 'robot@rbcos.ru'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.notify_client.subject
  #
  def notify_client(order)
    @order = order

    mail to: order.email,
         subject: 'Уведомление о новом заказе'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.notify_admin.subject
  #
  def notify_admin(order)
    @order = order

    mail to: %w(justvitalius@gmail.com),
         subject: 'Уведомление о новом заказе'
  end
end
