class ApplicationMailer < ActionMailer::Base
  default form: "k.kitayama1992@gmial.com",
          bcc:  "sample+sent@gmail.com",
          reply_to: "sample+reply@gmail.com"
  layout 'mailer'
end
