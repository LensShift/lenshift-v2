class StaticPage < ApplicationRecord
	belongs_to :lens_shifter
	validates :title, presence: true
	
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]
end
