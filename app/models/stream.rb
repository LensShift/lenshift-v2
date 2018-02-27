class Stream < ApplicationRecord
validates :title, presence: true
  belongs_to :lens_shifter
  has_many :lessons, dependent: :destroy
  accepts_nested_attributes_for :lessons, allow_destroy: true
   
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  acts_as_taggable_on :tags
   mount_uploader :image, ImageUploader

   scope :published_before, ->(time) { where("published_at <= ?", time)}
end
