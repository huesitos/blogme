class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :posts

  # Get a random number of posts that belong to that category.
  # The exclude array contains posts that should be excluded from
  # the random search.
  # The limit is the amount of posts we want at most.
  def random_posts(exclude=[], limit=3)
    category_posts = []

    posts_without_show_post = posts.where.not(id: exclude)

    for i in 0..limit-1
      rand_post = rand(posts_without_show_post.count-i)
      post = posts_without_show_post.where.not(id: category_posts.map { |p| p.id }).offset(rand_post).first
      category_posts << post if post
    end

    category_posts
  end
end
