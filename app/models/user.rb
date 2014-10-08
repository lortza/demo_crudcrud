class User < ActiveRecord::Base


  has_many :posts, :dependent => :destroy, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
  has_many :comments_on_posts, :through => :posts, :source => :comments
  # has_many :comments, :through => :posts
  
  before_create do |user|
    puts "about to create #{user.name}"
  end
  after_create :just_created

  protected
  def just_created
    puts "just created a user"
  end
end
