class AddPasswordDigestToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :password_digest, :string
    remove_column :authors, :password_hash
    remove_column :authors, :password_salt
  end
end
