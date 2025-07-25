class DataEntryMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.data_entry_mailer.thank_you_email.subject
  #
  def thank_you_email
    payload = params[:payload]
    template = params[:template]
    email = payload["email"] || payload["email_address"] || payload["address_email"] || payload["business_email"]
    return unless email.present?

    liquid_subject_tem = Liquid::Template.parse(template.subject)
    liquid_body_tem = Liquid::Template.parse(template.body)
    liquid_html_body_tem = Liquid::Template.parse(template.html_body)

    rendered_subject = liquid_subject_tem.render(payload)
    @rendered_body = liquid_body_tem.render(payload)
    @rendered_html_body = liquid_html_body_tem.render(payload)

    mail(to: email, subject: rendered_subject)
  end
end
