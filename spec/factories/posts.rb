FactoryGirl.define do

  factory :post do
    title Faker::Lorem.sentence(10).slice(0, 100)
    description Faker::Lorem.paragraph(5)

    factory :post_wa do
      author
    end
  end
end
