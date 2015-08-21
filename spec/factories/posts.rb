FactoryGirl.define do

  factory :post do
    title Faker::Lorem.sentence(10).slice(0, 100)
    description Faker::Lorem.paragraph(20)
    preview_image Faker::Avatar.image()

    factory :post_wa do
      author
    end
  end
end
