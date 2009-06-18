class User < ActiveRecord::Base
  include Crypt

  # Associations
  belongs_to :guild
  
  has_many :deposites
  has_many :orders
  
  #Validations
  validates_length_of :name, :within => 3..25, :allow_blank => false
  validates_uniqueness_of :name
  
  validates_associated :guild
  validates_associated :deposites
  
  validates_presence_of :password, :on => :create
  validates_length_of :password, :within => 6..25, :allow_blank => true
  validates_confirmation_of :password
  
  validates_length_of :dofusNicknames, :maximum => 255, :allow_blank => true
  
  validates_presence_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  
  # Scopes
  default_scope :order => :name, :include => :guild
  named_scope :admins, :conditions => {:admin => true}
  
  # Nested attributes
  accepts_nested_attributes_for :deposites, :allow_destroy => true
  
  # Callbacks
  before_create :makeActivationKey
  after_create :send_activation_mail
  
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
  
  def activate
    self.activationKey = nil
    self.activated = true
  end
  
  private
  
  def makeActivationKey
    self.activationKey = Array.new(64){rand(10).to_s}.join
  end
  
  def send_activation_mail
     UsersMailer.deliver_user_account_created(self)
  end
end
