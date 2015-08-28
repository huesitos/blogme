class EditImageFromAuthor < ActiveRecord::Migration
  def change
    change_column :authors, :image, :text, :default => 'no-profile-image.jpg'
  end
end
