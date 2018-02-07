class Stream < ApplicationRecord
  belongs_to :lens_shifter
  has_many :lessons
   
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  acts_as_taggable_on :tags
   paginates_per 10
   mount_uploader :image, ImageUploader


end
