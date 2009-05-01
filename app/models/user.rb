class User < ActiveRecord::Base
  
  # Associations
  belongs_to :guild
  
  has_many :deposites
  has_many :orders
  
  #Validations
  validates_length_of :name, :maximum => 25, :allow_blank => false
  validates_uniqueness_of :name
  
  validates_associated :guild
  validates_associated :deposites
  
  # Scopes
  default_scope :order => :name, :include => :guild
  named_scope :admins, :conditions => {:admin => true}
  
  # Nested attributes
  accepts_nested_attributes_for :deposites, :allow_destroy => true
  
  # Passwords can't be retrived
  def password
    ''
  end
  
  # For a new password we generate salt and hash 
  def password=(pass)
    if pass.blank?
      return
    end
    
    # Generate salt
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  end
  
  def autenticate(password)
    Digest::SHA256.hexdigest(password + self.password_salt) == self.password_hash
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
