class Lesson < ApplicationRecord
  validates :title, :length, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }
end
