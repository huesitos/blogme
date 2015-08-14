class Comment < ActiveRecord::Base
  belongs_to :post
  before_save :make_anonymous

  validates :content, presence: true

  def make_anonymous
    if self.name.empty?
      self.name = "Anonymous"
    end
  end
end
