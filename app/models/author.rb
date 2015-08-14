class Author < ActiveRecord::Base
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, presence: true, uniqueness: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: 'must have the format youremail@domain.com' }
  validates :password, length: { minimum: 6 }

  has_many :posts
end
