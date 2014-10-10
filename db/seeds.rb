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
Address.destroy_all
Photo.destroy_all



100.times do |i|
  u = User.create!(:name => "foo#{i+1}", :email => "foo#{i+1}@bar.com")
  3.times { Address.create!(:user_id => u.id, 
                            :street_address => "123 Fake Street",
                            :city => "Fake City",
                            :state => "Fake State",
                            :zip => "Fake Zip" ) }
end


50.times do |i|
  Post.create!(:title => "foopost#{i+1}", :body => "The best foopost#{i+1}", :author_id => User.all.sample.id)
  Photo.create(:title => "fooPhoto#{i+1}")
end

5000.times do |i|
  commentable_type = ["Photo","Post"].sample
  commentable_parent_id = commentable_type.constantize.all.sample.id
  Comment.create!(:body => "The best foo-comment#{i+1}", 
                  :author_id => User.all.sample.id, 
                  :commentable_id => commentable_parent_id,
                  :commentable_type => commentable_type)
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
