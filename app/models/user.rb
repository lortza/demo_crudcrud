class User < ActiveRecord::Base


  has_many :posts, :dependent => :destroy, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
  has_many :comments_on_posts, :through => :posts, :source => :comments
  has_many :addresses#, :inverse_of => :user

  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  has_secure_password
                                  
  accepts_nested_attributes_for :addresses, 
                                :reject_if => :all_blank, 
                                :allow_destroy => :true


  
  before_create do |user|
    # puts "about to create #{user.name}"
    generate_auth_token

  end
  after_create :just_created

  def self.with_friends
    sql = "
        SELECT *
        FROM users as initiating_frienders
        JOIN friendings 
          ON initiating_frienders.id = friendings.friender_id 
        JOIN users as receiving_frienders 
          ON friendings.friend_id = receiving_frienders.id"
    find_by_sql(sql)
  end

  def friends
    sql = "
      SELECT DISTINCT users.*
      FROM users
      JOIN friendings
        ON users.id = friendings.friender_id
      JOIN friendings AS reflected_friendings
        ON reflected_friendings.friender_id = friendings.friend_id
      WHERE reflected_friendings.friender_id = ?
      "
     User.find_by_sql([sql,self.id])
  end

  # unfamiliar syntax, but similar to `do_stuff if condition`
  # We'll keep trying to generate the token as long as there's
  # one identical to it somewhere in our users table
  def generate_auth_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_auth_token
    save!
  end

  protected
  def just_created
    # puts "just created a user"
  end


end
