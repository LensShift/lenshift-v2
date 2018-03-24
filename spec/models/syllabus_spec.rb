require 'rails_helper'

RSpec.describe Syllabus, type: :model do
	describe "Associations" do
		it "belongs to a resource_item" do
			assc = described_class.reflect_on_association(:resource_item)
			expect(assc.macro).to eq :belongs_to
		end

		it "belongs to a lesson" do
			assc = described_class.reflect_on_association(:lesson)
			expect(assc.macro).to eq :belongs_to
		end
	end

end
