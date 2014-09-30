class Tag < ActiveRecord::Base
  has_many :post_taggings
  has_many :posts, :through => :post_taggings
end