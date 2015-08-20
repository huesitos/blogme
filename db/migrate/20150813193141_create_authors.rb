class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :last_name
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :message
      t.string :role, default: 'editor'

      t.timestamps null: false
    end

    add_index :authors, :email, unique: true
  end
end
