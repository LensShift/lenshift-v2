class Lesson < ApplicationRecord
  belongs_to :stream
  has_many :resource_items, through: :syllabuses
end
