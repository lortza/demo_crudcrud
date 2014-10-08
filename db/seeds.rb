# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.destroy_all
Tag.destroy_all
PostTagging.destroy_all
User.destroy_all
Comment.destroy_all


10.times do |i|
  User.create!(:name => "foo#{i+1}", :email => "foo#{i+1}@bar.com")
end

50.times do |i|
  Post.create!(:title => "foopost#{i+1}", :body => "The best foopost#{i+1}", :author_id => User.all.sample.id)
end

100.times do |i|
  Comment.create!(:body => "The best foo-comment#{i+1}", :author_id => User.all.sample.id, :post_id => Post.all.sample.id)
end


5.times do |i|
  Tag.create!(:name => "footag#{i+1}")
end

tags = Tag.all
posts = Post.all
relationships = 0

300.times do |i|
  pt = PostTagging.new(:tag_id => tags.sample.id, :post_id => posts.sample.id)
  if pt.save
    relationships+=1
  end
end
puts "\n\n Created #{relationships} Post Taggings\n\n"
