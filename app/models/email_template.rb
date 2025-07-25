class EmailTemplate < ApplicationRecord
  belongs_to :form, polymorphic: true
end
