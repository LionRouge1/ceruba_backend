class DataEntry < ApplicationRecord
  belongs_to :form

  validates :ip_address, presence: true
  validates :user_agent, presence: true
  validates :origin, presence: true
  validates :payload, presence: true

  def data_payload
    JSON.parse(payload)
  end

  def deliver_email_if_template_exists
    if form.email_template.present?
      DataEntryMailer.with(payload: data_payload, template: form.email_template).send_form_email.deliver_later
    end
  end
end
