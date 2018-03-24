require 'rails_helper'

RSpec.describe Profile, type: :model do
	describe "Associations" do
		it "belongs to a lensShifter" do
			assc = described_class.reflect_on_association(:lens_shifter)
			expect(assc.macro).to eq :belongs_to
		end
	end
end
