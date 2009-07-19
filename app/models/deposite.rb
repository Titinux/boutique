class Deposite < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset
  
  # Validations
  validates_presence_of :user, :asset
  
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  
  # Scopes
  default_scope :include => :asset, :order => 'assets.name'
  
  named_scope :deposites_of, lambda {|asset| { :conditions => ["asset_id = ?", asset.id]}}
  named_scope :validated, lambda {|*args| { :conditions => ["validated = ?", (args.empty? ? true : args.first)]}}
  
  def self.stock(asset)
    validated.deposites_of(asset).sum(:quantity)
  end
  
  def addQuantity
    0
  end
  
  def addQuantity=(value)
    self.quantity ||= 0
    
    self.quantity += value.to_i
  end
  
  def self.compact(&block)
    raise ArgumentError, "Missing block" unless block_given?

    false    
    self.transaction do
      
      return unless block.call
    
      groups = Deposite.all.group_by do |deposite|
        [deposite.user_id, deposite.asset_id, deposite.validated]
      end
      
      groups.values.each do |group|
        next if group.size < 2
        
        group.first.quantity = group.sum(&:quantity)
        group.shift.save

        group.each(&:delete)
      end
    end
    
    true
  end
end
