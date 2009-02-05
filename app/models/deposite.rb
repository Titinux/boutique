class Deposite < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset
  
  named_scope :deposites_of, lambda {|asset| { :conditions => ["asset_id = ?", asset.id]} }
  
  def self.stock(asset)
    deposites_of(asset).sum(:quantity)
  end
end
