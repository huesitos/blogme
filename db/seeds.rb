Author.destroy_all
Post.destroy_all
Tag.destroy_all

tag1 = FactoryGirl.create(:tag, name: 'cooking')
tag2 = FactoryGirl.create(:tag, name: 'sports')
tag3 = FactoryGirl.create(:tag, name: 'health')
tag4 = FactoryGirl.create(:tag, name: 'life')

denisse = FactoryGirl.create(:author)

FactoryGirl.create(:post).tags << [tag1, tag2]
FactoryGirl.create(:post).tags << [tag3, tag4]
FactoryGirl.create(:post).tags << [tag2, tag3]

Post.all.each { |p| denisse.posts << p }
