class AddNicknameToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :nickname, :string

    add_index :authors, :nickname, unique: true
  end
end
