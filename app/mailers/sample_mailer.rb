class SampleMailer < ApplicationMailer
  default from: "k.kitayama1992@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.send_when_purchase.subject
  #
  def send_when_purchase(order)
    @order = order

    mail to:  order.client.email,
         subject: 'ご購入が完了しました。'
  end
end
