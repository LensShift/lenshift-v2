FactoryBot.define do
  factory :lens_shifter do
    email 'dummyEmail@gmail.com'
    password 'MyString'
    password_confirmation "MyString"
    admin false
  end

  factory :fellow, class: LensShifter do
    email 'adminEmail@gmail.com'
    password 'MyString'
    password_confirmation "MyString"
    admin true
  end
end
