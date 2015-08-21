suckr = ImageSuckr::GoogleSuckr.new

Author.destroy_all
Post.destroy_all
Tag.destroy_all
Comment.destroy_all
Category.destroy_all

printable = FactoryGirl.create(:category)
paper_craft = FactoryGirl.create(:category, name: 'Papercraft')

tag1 = FactoryGirl.create(:tag, name: 'cooking')
tag2 = FactoryGirl.create(:tag, name: 'sports')
tag3 = FactoryGirl.create(:tag, name: 'health')
tag4 = FactoryGirl.create(:tag, name: 'life')

denisse = FactoryGirl.create(:author, role: 'admin')
denisse.social_links[:google] = "https://plus.google.com/u/0/+DenisseMargaritaLaraMart%C3%ADn/about"
denisse.save

FactoryGirl.create(:post, category: printable).tags << [tag2, tag3]
FactoryGirl.create(:post, created_at: Date.yesterday, category: printable).tags << [tag1, tag2]
FactoryGirl.create(:post, created_at: Date.yesterday - 1, category: printable).tags << [tag3, tag4]
FactoryGirl.create(:post, created_at: 1.month.ago, category: paper_craft).tags << [tag3, tag4]
FactoryGirl.create(:post, created_at: 2.months.ago, category: printable).tags << [tag3, tag4]
FactoryGirl.create(:post, created_at: 1.year.ago, category: paper_craft).tags << [tag3, tag4]

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

p1 = FactoryGirl.create(:post, created_at: 3.days.ago, category: printable)
p1.tags << tag5
p2 = FactoryGirl.create(:post, created_at: 4.days.ago, category: paper_craft)
p2.tags << [tag5, tag4]
p3 = FactoryGirl.create(:post, created_at: 5.days.ago, category: printable)
p3.tags << tag5

nicole.posts << [p1, p2, p3]

Post.all.each { |p| p.comments << FactoryGirl.create(:comment) }
