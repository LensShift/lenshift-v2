class TeamMember < ApplicationRecord
	 mount_uploader :avatar, ImageUploader

	 validates :name, presence: true
end
