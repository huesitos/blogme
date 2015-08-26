require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  before(:each) {
    category.posts << create_list(:post, 4)
  }

  describe "#random_posts" do

    it "returns different posts" do
      posts = category.random_posts()

      expect(posts.uniq).to eq posts
    end

    it "returns a number of random posts specified by the limit" do
      limit = 3
      posts = category.random_posts([], limit)
      expect(posts.length).to be <= limit
    end

    it "excludes posts" do
      apost = Post.first
      posts = category.random_posts([apost.id])
      expect(posts).not_to include(apost)
    end
  end
end
