class Blog < ApplicationRecord
	validates :title, presence: true
	scope :published_before, ->(time) { where("published_at <= ?", time)}
	belongs_to :lens_shifter
	extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  acts_as_taggable_on :tags
end
