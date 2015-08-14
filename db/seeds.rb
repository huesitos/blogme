Author.destroy_all
Post.destroy_all
Tag.destroy_all
Comment.destroy_all

tag1 = FactoryGirl.create(:tag, name: 'cooking')
tag2 = FactoryGirl.create(:tag, name: 'sports')
tag3 = FactoryGirl.create(:tag, name: 'health')
tag4 = FactoryGirl.create(:tag, name: 'life')

denisse = FactoryGirl.create(:author, role: 'admin')

FactoryGirl.create(:post).tags << [tag1, tag2]
FactoryGirl.create(:post).tags << [tag3, tag4]
FactoryGirl.create(:post).tags << [tag2, tag3]

Post.all.each { |p| denisse.posts << p }

nicole = FactoryGirl.create(:author,
  email: 'nicolelaramartin@gmail.com',
  nickname: 'nicole',
  role: 'editor')

tag5 = FactoryGirl.create(:tag, name: 'art')

p1 = FactoryGirl.create(:post)
p1.tags << tag5
p2 = FactoryGirl.create(:post)
p2.tags << [tag5, tag4]
p3 = FactoryGirl.create(:post)
p3.tags << tag5

nicole.posts << [p1, p2, p3]

Post.all.each { |p| p.comments << FactoryGirl.create(:comment) }
