class Post < ActiveRecord::Base
  validates :title, :description, presence: true
end
