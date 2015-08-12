FactoryGirl.define do
  factory :post do
    title Faker::Lorem.characters(150)
    description Faker::Lorem.paragraph(5)
  end

end
