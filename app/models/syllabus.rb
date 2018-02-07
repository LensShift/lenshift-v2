class Syllabus < ApplicationRecord
  belongs_to :lesson
  belongs_to :resource_item
end
