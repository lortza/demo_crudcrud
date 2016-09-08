class Address < ApplicationRecord

  belongs_to :user#, :inverse_of => :addresses
  has_one :billing_user, :foreign_key => :billing_address_id, :class_name => "User"
  # validates :city, :length => { :within => 1..2 }

end
