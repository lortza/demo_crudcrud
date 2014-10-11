class Post < ActiveRecord::Base

  validates :title, :body, :length => {:maximum => 20}

  belongs_to :author, :class_name => "User", :counter_cache => true
  has_many :post_taggings
  has_many :tags, :through => :post_taggings
  has_many :comments, :as => :commentable, :dependent => :destroy

  # accepts_nested_attributes_for :tags

end
