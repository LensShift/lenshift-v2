FactoryBot.define do
  factory :static_page do
    title { "MyString" }
    content { "MyText" }
    slug { "MyString" }
    lens_shifter
  end
end
