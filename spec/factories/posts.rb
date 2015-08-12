FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence(10)
    description Faker::Lorem.paragraph(5)
  end

end
