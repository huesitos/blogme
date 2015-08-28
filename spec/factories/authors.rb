FactoryGirl.define do

  factory :author do
    name "Denisse Margarita"
    last_name "Lara Martin"
    nickname "denisse"
    email "dmlaramartin@gmail.com"
    password '123456'
    image "https://lh5.googleusercontent.com/-WmhCxsI_pds/VW--rLHXvrI/AAAAAAAAAcM/UvKhmhf7XCI/s778-no/IMG_0253.JPG"
    message "There is nothing quite so useless, as doing with great efficiency, something that should not be done at all. - Peter Drucker"
    bio Faker::Lorem.sentence(50)
    role "admin"
  end

  factory :rauthor, class: Author do
    name Faker::Name.first_name
    last_name Faker::Name.last_name
    nickname Faker::Internet.user_name
    email Faker::Internet.email
    password Faker::Internet.password
    image Faker::Avatar.image
    message Faker::Lorem.sentence
    role "editor"
  end
end
