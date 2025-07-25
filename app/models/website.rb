class Website < ApplicationRecord
  has_many :forms, dependent: :nullify
  belongs_to :user

  # enum status: { active: 0, inactive: 1 }

  validates :name, presence: true
  validates :url, presence: true, format: URI::regexp(%w[http https])
  validates :status, presence: true, numericality: { only_integer: true }
end
