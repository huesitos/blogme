class RelatePostsWithCategories < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.belongs_to :category, index: true
    end
  end
end
