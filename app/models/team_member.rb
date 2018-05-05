class TeamMember < ApplicationRecord
	 mount_uploader :avatar, ImageUploader
end
