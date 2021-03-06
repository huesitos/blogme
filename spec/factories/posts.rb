suckr = ImageSuckr::GoogleSuckr.new

FactoryGirl.define do

  factory :post do
    title Faker::Lorem.sentence(7)
    description Faker::Lorem.paragraph(20)
    preview_image suckr.get_image_url({"q"=>"art"})

    factory :post_wc do
      category
    end

    factory :post_wa do
      author
    end
  end
end
