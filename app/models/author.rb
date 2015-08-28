class Author < ActiveRecord::Base
  serialize :social_links
  has_secure_password

  before_save :empty_image?

  validates :email, :nickname, :name, :last_name, presence: true
  validates :email, :nickname, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: 'must have the format youremail@domain.com' }
  validates :nickname, format: {
    with: /\w{1}/,
    message: "must not contain white spaces"
  }
  validates :bio, length: { maximum: 500 }
  validates :image, format: {
    with: /\w+((.png|.PNG)|(.gif|.GIF)|(.jpg|.JPG)|(.bmp|.BMP))\z/,
    message: "url must point to an image"},
    unless: 'image.empty?'

  validates :password, length: { minimum: 6 }, on: :create

  has_many :posts

  def empty_image?
    if self.image.empty?
      self.image = 'no-profile-image.jpg'
    end
  end
end
