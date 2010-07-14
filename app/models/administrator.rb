class Administrator < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable,
         :lockable, :timeoutable, :unlock_strategy => :none

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :locked_at

  validates :name, :presence => true, :uniqueness => true
end
