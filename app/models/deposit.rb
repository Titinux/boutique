class Deposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset

  # Virtual attributes
  attr_accessor :quantity_modifier

  # Attributes protection
  attr_accessible :user_id, :asset_id, :validated, :quantity_modifier

  # Validations
  validates_presence_of :user, :asset

  validates_numericality_of :quantity, :only_integer => true
  validates_numericality_of :quantity_modifier, :only_integer => true

  validate :not_duplicate
  validate :coherant_quantity

  # Callbacks
  before_save :compute_quantity
  after_save :delete_me_if_empty

  # Scopes
  default_scope :include => :asset, :order => 'assets.name'

  named_scope :deposits_of, lambda {|asset| { :conditions => ["asset_id = ?", asset.id]}}
  named_scope :validated, lambda {|*args| { :conditions => ["validated = ?", (args.empty? ? true : args.first)]}}

  # Default values
  def after_initialize
    self[:quantity] ||= 0
    self[:quantity_modifier] ||= 0
  end

  # Approve a deposit
  def approve
    # Find a validated duplicate.
    stock = Deposit.find_or_new({:user_id => user_id, :asset_id => asset_id, :validated => true})

    stock.quantity += self.quantity
    stock.save

    self.destroy
  end

  # Class method to get the total amount of an asset
  def self.stock(asset)
    validated.deposits_of(asset).sum(:quantity)
  end

  def self.find_or_new(params)
    Deposit.find(:first, :conditions => params) || Deposit.new(params)
  end

  private

  # Validation
  def not_duplicate
    unless Deposit.find(:first, :conditions =>{ :user_id => self.user_id, :asset_id => self.user_id, :validated => self.validated }).blank?
      errors.add_to_base("Duplicate deposit is forbidden !")
    end
  end

  # Validation
  def coherant_quantity
    final_quantity = self.quantity.to_i + self.quantity_modifier.to_i
    potential_user_stock = Deposit.find(:all, :conditions => { :user_id => self.user_id, :asset_id => self.asset_id }).sum(&:quantity)

    if self.validated?
      errors.add_to_base("Stock quantity can\'t be negative !") if final_quantity < 0
    else
      errors.add_to_base("Withdrawal amount can\'t be superior to deposits !") if self.quantity_modifier.to_i + potential_user_stock < 0
    end
  end

  # Before save
  def compute_quantity
    self.quantity += self.quantity_modifier.to_i
  end

  # After save
  def delete_me_if_empty
    if self.quantity == 0
      self.delete
    end
  end
end
