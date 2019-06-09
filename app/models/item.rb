class Item < ApplicationRecord
  acts_as_list
  belongs_to :list
  validates :title, presence: true, strict: true

  scope :by_position, -> { order(:position) }
end
