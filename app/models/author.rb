class Author < ActiveRecord::Base
  serialize :social_links
  has_secure_password

  validates_presence_of :password_digest, :on => :create
  validates :email, :nickname, presence: true, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: 'must have the format youremail@domain.com' }
  validates :nickname, format: {
    with: /\w{1}/,
    message: "must not contain white spaces"
  }
  validates :password_digest, length: { minimum: 6 }

  has_many :posts
end
