class Address < ActiveRecord::Base

  belongs_to :user#, :inverse_of => :addresses
  # validates :city, :length => { :within => 1..2 }
end
