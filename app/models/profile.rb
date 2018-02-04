class Profile < ApplicationRecord
  belongs_to :lens_shifter
  geocoded_by :location
  after_validation :geocode
  mount_uploader :avatar, ImageUploader

  SECTORS = ['accommodation & food services',
      'administrative & support services',
      'agriculture, forestry & fishing',
      'construction',
      'education',
      'financial & insurance activities',
      'human health & social work activities',
      'information & communication',
      'manufacturing',
      'mining, energy and water supply',
      'professional, scientific & technical activities',
      'public admin & defence; social security',
      'real estate activities',
      'transport & storage',
      'utilities',
      'wholesale, retail & repair of motor vehicles',
      'other services']

end
