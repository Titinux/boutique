class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :validatable,
         :timeoutable, :recoverable, :trackable, :lockable,
         :encryptor => :boutique_encryptor,
         :unlock_strategy => :email,
         :timeout_in => 15.days

  # Attributes
  attr_accessible :name, :email, :password, :password_confirmation,
                  :pigMoneyBox, :dofusNicknames, :guild_id, :gatherer,
                  :blocked

  # Associations
  belongs_to :guild

  has_many :deposits
  has_many :orders

  #Validations
  validates :name, :presence => true, :uniqueness => true, :length => 3..25, :allow_blank => false

  validates_associated :guild
  validates_associated :deposits

  validates_length_of :dofusNicknames, :maximum => 255, :allow_blank => true

  # Scopes
  default_scope :order => :name

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    User.unscoped.where("name = ? or email = ?", value, value).first
  end

  def addMoney
    @addMoney ||= 0
  end

  def addMoney=(value)
    @addMoney = value.to_i
    self.pigMoneyBox ||= 0

    self.pigMoneyBox += @addMoney
  end

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
