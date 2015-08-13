class AuthorPostAssociation < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.belongs_to :author, index: true
    end
  end
end
