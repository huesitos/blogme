FactoryGirl.define do

  factory :author do
    name "Denisse Margarita"
    last_name "Lara Martin"
    email "dmlaramartin@gmail.com"
    password Faker::Internet.password(6)
    image "https://lh5.googleusercontent.com/-WmhCxsI_pds/VW--rLHXvrI/AAAAAAAAAcM/UvKhmhf7XCI/s778-no/IMG_0253.JPG"
    message "There is nothing quite so useless, as doing with great efficiency, something that should not be done at all. - Peter Drucker"
  end
end
