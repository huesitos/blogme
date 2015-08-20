class AddSocialLinksToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :social_links, :text,
      default: {
        google: '',
        youtube: '',
        instagram: '',
        pinterest: '',
        etsy: ''
      }
  end
end
