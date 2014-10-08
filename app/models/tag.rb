class Tag < ActiveRecord::Base
  has_many :post_taggings
  has_many :tagged_posts, :through => :post_taggings, :source => :post
end