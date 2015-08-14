class AddRoleToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :role, :string, default: 'editor'
  end
end
