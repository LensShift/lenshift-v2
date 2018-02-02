class LensShifter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :lens_shifter_profile
  has_one :profile
  has_many :resource_items

  def full_name
  	self.profile.nil? ? self.email : "#{self.profile.first_name} #{self.profile.last_name}" 
  end
end
