class Deposite < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset
  
  # Validations
  validates_presence_of :user_id
  validates_presence_of :asset_id
  
  # Scopes
  default_scope :include => :asset, :order => 'assets.name'
  
  named_scope :deposites_of, lambda {|asset| { :conditions => ["asset_id = ?", asset.id]}}
  named_scope :validated?, lambda {|*args| { :conditions => ["validated = ?", (args.empty? ? true : args.first)]}}
  
  # Callbacks
  before_save :compact
  
  def self.stock(asset)
    deposites_of(asset).sum(:quantity)
  end
  
  def addQuantity
    0
  end
  
  def addQuantity=(value)
    self.quantity ||= 0
    
    self.quantity += value.to_i
  end
  
  def compact
    slaves = Deposite.find(:all, :conditions => {:user_id => self.user_id, :asset_id => self.asset_id, :validated => self.validated})
    
    slaves.delete_if {|slave| slave.id == self.id } unless self.new_record?
    
    self.quantity += slaves.sum(&:quantity)
    slaves.each {|slave| slave.delete }
    
    true
  end
end
