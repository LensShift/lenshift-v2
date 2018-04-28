class Document < ApplicationRecord
	mount_uploader :file, FileUploader
end
