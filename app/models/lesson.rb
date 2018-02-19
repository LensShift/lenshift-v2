class Lesson < ApplicationRecord
  belongs_to :stream
  has_many :syllabuses, dependent: :destroy
  has_many :resource_items, through: :syllabuses
  accepts_nested_attributes_for :syllabuses, allow_destroy: true
  include RankedModel
  ranks :row_order
end
