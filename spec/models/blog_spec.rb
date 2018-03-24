require 'rails_helper'

RSpec.describe Blog, type: :model do
	let (:user) {FactoryBot.create(:fellow)}
	subject { FactoryBot.create(:blog, lens_shifter: user)}
	it "is valid with valid attributes" do
		expect(subject).to be_valid
	end

	it "is not valid without a title" do
		subject.title = nil
		expect(subject).to_not be_valid
	end

	describe "Associations" do
		it "belongs to a lensShifter author" do
			assc = described_class.reflect_on_association(:lens_shifter)
			expect(assc.macro).to eq :belongs_to
		end
	end
end
