class Photo < ApplicationRecord
	# validates :image, presence: true
	mount_uploader :image, ImageUploader
end
