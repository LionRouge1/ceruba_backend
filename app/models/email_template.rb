class EmailTemplate < ApplicationRecord
  belongs_to :emailable, polymorphic: true
  has_rich_text :html_body
end
