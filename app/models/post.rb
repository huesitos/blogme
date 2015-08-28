class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, length: { maximum: 140 }
  validates :preview_image, format: {
    with: /\w+((.png|.PNG)|(.gif|.GIF)|(.jpg|.JPG)|(.bmp|.BMP))\z/,
    message: "url must point to an image"},
    unless: 'preview_image.empty?'

  belongs_to :author
  belongs_to :category
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy
end