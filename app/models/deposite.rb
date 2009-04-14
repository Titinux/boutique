class Deposite < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset
  
  # Scopes
  default_scope :include => :asset, :order => 'assets.name'
  
  named_scope :deposites_of, lambda {|asset| { :conditions => ["asset_id = ?", asset.id]} }
  
  
  
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
end
