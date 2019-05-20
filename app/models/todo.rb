class Todo < ApplicationRecord
  validates :title, presence: true, strict: true
end
