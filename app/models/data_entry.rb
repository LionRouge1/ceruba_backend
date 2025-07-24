class DataEntry < ApplicationRecord
  belongs_to :form

  validates :country, presence: true
  validates :ip_address, presence: true
  validates :user_agent, presence: true
  validates :origin, presence: true
  validates :payload, presence: true
end
