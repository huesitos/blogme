class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, length: { maximum: 140 }

  belongs_to :author
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy
end