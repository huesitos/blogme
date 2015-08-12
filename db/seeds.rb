# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.destroy_all
Tag.destroy_all

tag1 = FactoryGirl.create(:tag, name: 'cooking')
tag2 = FactoryGirl.create(:tag, name: 'sports')
tag3 = FactoryGirl.create(:tag, name: 'health')
tag4 = FactoryGirl.create(:tag, name: 'life')

FactoryGirl.create(:post).tags << [tag1, tag2]
FactoryGirl.create(:post).tags << [tag3, tag4]
FactoryGirl.create(:post).tags << [tag2, tag3]
