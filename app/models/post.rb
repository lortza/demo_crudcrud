class Post < ActiveRecord::Base

  validates :title, :body, :length => {:maximum => 20}

  belongs_to :user
  has_many :post_taggings
  has_many :tags, :through => :post_taggings
  has_many :comments, :dependent => :destroy

end
