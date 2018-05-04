class LensShifter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile
  has_many :resource_items
  has_many :guides
  has_many :streams
  has_many :static_pages
  has_many :blogs

  def full_name
  	self.profile.nil? ? self.email : "#{self.profile.first_name} #{self.profile.last_name}" 
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
end
