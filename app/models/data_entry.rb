class DataEntry < ApplicationRecord
  belongs_to :form

  validates :ip_address, presence: true
  validates :user_agent, presence: true
  validates :origin, presence: true
  validates :payload, presence: true

  after_commit :deliver_email_if_template_exists

  def data_payload
    JSON.parse(payload).map { |key, value| [ key.downcase, value ] }.to_h
  end

  def deliver_email_if_template_exists
    if form.email_template.present?
      DataEntryMailer.with(payload: data_payload, template: form.email_template).thank_you_email.deliver_later
    end
  end
end
