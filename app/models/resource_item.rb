class ResourceItem < ApplicationRecord
  belongs_to :lens_shifter
  has_many :syllabuses
  has_many :lessons, through: :syllabuses
  validates :title, presence: true
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  acts_as_taggable_on :tags, :author
   paginates_per 8
   mount_uploader :image, ImageUploader

   RESOURCE_TYPE = {
   	"academic": "university",
	'article': "pencil-square-o",
	'blog': "blogger",
	'book': "book",
	'document': "file",
	'graphic': "picture-o",
	'podcast': "podcast",
	'reference': "building",
	'video': "video-camera",
	'website': "window-maximize",
	'other': "certificate"
   }

   	def type_icon
		RESOURCE_TYPE[self.resource_type.to_sym]
	end

  	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |item|
				csv << item.attributes.values_at(*column_names)
			end
		end
	end

	def self.import_csv(file)
		CSV.foreach(file.path, headers: true) do |row|
			item = find_by_id(row["id"]) || new
			item.attributes = row.to_hash.slice(*self.column_names)
			# item.title = "#{item.advertiser} #{item.starts.strftime('%d-%m-%Y')}" if item.starts.present?
			item.tag_list = row["tags"]
			item.save!
		end
	end

	def self.import_json(file)
		resource_list = JSON.parse(File.read(file.path))
		resource_list.each do |item|
			ResourceItem.create(item.to_hash)
		end
	end
end
