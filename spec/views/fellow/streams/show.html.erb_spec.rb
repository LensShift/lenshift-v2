require 'rails_helper'

RSpec.describe "fellow/streams/show", type: :view do
  before(:each) do
  	fellow = FactoryBot.create(:fellow)
    @stream = assign(:stream, fellow.streams.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
