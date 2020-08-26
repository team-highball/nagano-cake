# Preview all emails at http://localhost:3000/rails/mailers/sample_mailer
class SampleMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sample_mailer/send_when_purchase
  def send_when_purchase
    SampleMailer.send_when_purchase
  end

end
