class Administrator < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable,
         :lockable, :timeoutable, :unlock_strategy => :none

  # Attributes
  attr_accessible :name, :email, :password, :password_confirmation, :blocked
  attr_searchable  :name, :email

  # Validations
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 3..25 }

  def blocked=(value)
    if value == '1'
      self.locked_at = Time.now unless self.blocked
    else
      self.locked_at = nil
    end
  end

  def blocked
    ! self.locked_at.nil?
  end
end
