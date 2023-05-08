FactoryBot.define do
  factory :lens_shifter do
    sequence(:email) {|n| "dummyEmail#{n}@gmail.com" } 
    password { "MyString" }
    password_confirmation { "MyString" }
    admin { false }
  end

  factory :fellow, class: LensShifter do
    sequence(:email) {|n| "adminEmail#{n}@gmail.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
    admin { true }
  end
end
