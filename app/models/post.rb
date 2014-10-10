class Post < ActiveRecord::Base

  validates :title, :body, :length => {:maximum => 20}

  belongs_to :author, :class_name => "User"#, :foreign_key => :author_id
  has_many :post_taggings
  has_many :tags, :through => :post_taggings
  has_many :comments, :as => :commentable, :dependent => :destroy

end
