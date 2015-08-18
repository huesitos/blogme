Author.destroy_all
Post.destroy_all
Tag.destroy_all
Comment.destroy_all

tag1 = FactoryGirl.create(:tag, name: 'cooking')
tag2 = FactoryGirl.create(:tag, name: 'sports')
tag3 = FactoryGirl.create(:tag, name: 'health')
tag4 = FactoryGirl.create(:tag, name: 'life')

denisse = FactoryGirl.create(:author, role: 'admin')

FactoryGirl.create(:post).tags << [tag2, tag3]
FactoryGirl.create(:post, created_at: Date.yesterday).tags << [tag1, tag2]
FactoryGirl.create(:post, created_at: Date.yesterday - 1).tags << [tag3, tag4]

Post.all.each { |p| denisse.posts << p }

nicole = Author.create(
  name: "Nicole Margarita",
  last_name: "Lara Martin",
  email: 'nicolelaramartin@gmail.com',
  nickname: 'nicole',
  role: 'editor',
  password: '123456',
  image: 'https://lh3.googleusercontent.com/-f-cGH3EJEac/AAAAAAAAAAI/AAAAAAAAGFE/LQyCnWjEvTU/s120-c/photo.jpg')

tag5 = FactoryGirl.create(:tag, name: 'art')

p1 = FactoryGirl.create(:post, created_at: 3.days.ago)
p1.tags << tag5
p2 = FactoryGirl.create(:post, created_at: 4.days.ago)
p2.tags << [tag5, tag4]
p3 = FactoryGirl.create(:post, created_at: 5.days.ago)
p3.tags << tag5

nicole.posts << [p1, p2, p3]

Post.all.each { |p| p.comments << FactoryGirl.create(:comment) }
