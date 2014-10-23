# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "destroying old data"

Post.delete_all
Tag.delete_all
PostTagging.delete_all
User.delete_all
Comment.delete_all
Address.delete_all
Photo.delete_all


puts "creating users"
100.times do |i|
  u = User.create!(:name => "foo#{i+1}", :email => "foo#{i+1}@bar.com", :password => "foobar")
  3.times { Address.create!(:user_id => u.id, 
                            :street_address => "123 Fake Street",
                            :city => "Fake City",
                            :state => "Fake State",
                            :zip => "Fake Zip" ) }
  u.billing_address = u.addresses.first
  u.save!
end
puts "created users, creating posts and photos"

50.times do |i|
  Post.create!(:title => "foopost#{i+1}", :body => "The best foopost#{i+1}", :author_id => User.all.sample.id)
  Photo.create!(:title => "fooPhoto#{i+1}")
end

puts "created posts and photos, creating comments"

500.times do |i|
  commentable_type = ["Photo","Post"].sample
  commentable_parent_id = commentable_type.constantize.all.sample.id
  Comment.create!(:body => "The best foo-comment#{i+1}", 
                  :author_id => User.all.sample.id, 
                  :commentable_id => commentable_parent_id,
                  :commentable_type => commentable_type)
end

puts "created comments, creating tags"

5.times do |i|
  Tag.create!(:name => "footag#{i+1}")
end

puts "created tags, tagging posts"

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
