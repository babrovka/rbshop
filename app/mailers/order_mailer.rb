class OrderMailer < ActionMailer::Base
  default from: "robot@rbcos.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.notify_client.subject
  #
  def notify_client(order)
    @name = order.name
    @number = order.id
    @line_item = order.line_items

    mail to: order.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.notify_admin.subject
  #
  def notify_admin(order)
    @number = order.id

    mail to: 'babrovka@gmail.com'
  end
end
