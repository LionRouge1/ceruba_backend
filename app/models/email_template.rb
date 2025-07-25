class EmailTemplate < ApplicationRecord
  belongs_to :emailable, polymorphic: true
  has_rich_text :html_body

  validates :name, presence: true, uniqueness: true
  validates :body, presence: true
  validates :subject, presence: true
end
