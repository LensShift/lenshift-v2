class Syllabus < ApplicationRecord
  belongs_to :lesson
  belongs_to :resource_item
  include RankedModel
  ranks :row_order, with_same: :lesson_id
  default_scope {order(:row_order)}
end
