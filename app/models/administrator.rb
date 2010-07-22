class Administrator < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable,
         :lockable, :timeoutable, :unlock_strategy => :none

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :blocked

  validates :name, :presence => true, :uniqueness => true

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
