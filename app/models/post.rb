class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, length: { maximum: 100 }

  belongs_to :author
  has_and_belongs_to_many :tags
end
