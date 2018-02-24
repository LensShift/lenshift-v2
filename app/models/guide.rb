class Guide < ApplicationRecord
  belongs_to :lens_shifter
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  scope :published_before, ->(time) { where("published_at <= ?", time)}


end
