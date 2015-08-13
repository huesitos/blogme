class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :image
      t.string :message

      t.timestamps null: false
    end

    add_index :authors, :email, unique: true
  end
end
