FactoryGirl.define do
  factory :page do
    name "About"
    content Faker::Lorem.paragraphs(3)
  end
end
