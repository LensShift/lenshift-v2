require 'rails_helper'

RSpec.describe Guide, type: :model do
	describe "Associations" do
		it "belongs to a lensShifter author" do
			assc = described_class.reflect_on_association(:lens_shifter)
			expect(assc.macro).to eq :belongs_to
		end
	end
end
