class DataEntry < ApplicationRecord
  belongs_to :form

  validates :ip_address, presence: true
  validates :user_agent, presence: true
  validates :origin, presence: true
  validates :payload, presence: true
end
