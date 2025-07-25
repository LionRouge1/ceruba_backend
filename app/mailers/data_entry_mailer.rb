class DataEntryMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.data_entry_mailer.thank_you_email.subject
  #
  def thank_you_email
    @payload = params[:payload]
    subject = "🌍 Welcome to Ceruba. Let’s Transform Corporate Travel Together"

    mail to: "to@example.org", subject: subject
  end
end
