class LensShifterProfile < ApplicationRecord
  belongs_to :lens_shifter
  geocoded_by :location
  after_validation :geocode
end
