class Post < ActiveRecord::Base
  validates :title, :description, presence: true
  validates :title, length: { maximum: 150 }
end
