class User < ActiveRecord::Base
  include Crypt

  # Associations
  belongs_to :guild
  
  has_many :deposites
  has_many :orders
  
  #Validations
  validates_length_of :name, :maximum => 25, :allow_blank => false
  validates_uniqueness_of :name
  
  validates_associated :guild
  validates_associated :deposites
  
  validates_length_of :password, :within => 6..25
  validates_confirmation_of :password
  
  validates_length_of :dofusNicknames, :maximum => 255, :allow_blank => true
  
  # Scopes
  default_scope :order => :name, :include => :guild
  named_scope :admins, :conditions => {:admin => true}
  
  # Nested attributes
  accepts_nested_attributes_for :deposites, :allow_destroy => true
  
  # Passwords can't be retrived
  def password
    @password ||= ''
  end
  
  # For a new password we generate salt and hash 
  def password=(pass)
    return if pass.blank?
    
    @password = pass
    
    # Generate salt
    salt = computeSalt
    
    self.password_salt, self.password_hash = salt, computePassword(salt, pass)
  end
  
  def autenticate(password)
    computePassword(self.password_salt, password) == self.password_hash
  end
  
  def addMoney
    @addMoney ||= 0
  end
  
  def addMoney=(value)
    @addMoney = value.to_i
    self.pigMoneyBox ||= 0
    
    self.pigMoneyBox += @addMoney
  end
end
