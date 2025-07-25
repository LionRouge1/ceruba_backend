# Preview all emails at http://localhost:3000/rails/mailers/data_entry_mailer
class DataEntryMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/data_entry_mailer/thank_you_email
  def thank_you_email
    DataEntryMailer.thank_you_email
  end
end
