class User < ActiveRecord::Base


  has_many :posts, :dependent => :destroy, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
  has_many :comments_on_posts, :through => :posts, :source => :comments
  has_many :addresses#, :inverse_of => :user

  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friends,              :through => :initiated_friendings,
                                  :source => :friend_recipient

  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

                                  

  accepts_nested_attributes_for :addresses, :reject_if => :all_blank


  
  before_create do |user|
    puts "about to create #{user.name}"
  end
  after_create :just_created

  protected
  def just_created
    puts "just created a user"
  end
end
