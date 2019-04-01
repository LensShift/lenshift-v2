class StaticPage < ApplicationRecord
	belongs_to :lens_shifter
	validates :title, presence: true
	mount_uploader :image, ImageUploader
	
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]

	acts_as_taggable_on :placements
end
