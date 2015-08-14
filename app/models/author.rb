class Author < ActiveRecord::Base
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  has_many :posts
end
