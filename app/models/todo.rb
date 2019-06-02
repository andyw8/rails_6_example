class Todo < ApplicationRecord
  acts_as_list
  validates :title, presence: true, strict: true

  scope :by_position, -> { order(:position) }
end
