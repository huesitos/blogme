class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :preview_image
      t.text :description
      t.integer :view_count, default: 0

      t.timestamps null: false
    end
  end
end
