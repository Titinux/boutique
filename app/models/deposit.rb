class Deposit < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :asset

  # Attributes
  attr_accessor :quantity_modifier
  attr_accessible :user_id, :asset_id, :validated, :quantity_modifier
  attr_searchable
  assoc_searchable :user, :asset

  # Validations
  validates_presence_of :user_id, :asset_id

  validates_numericality_of :quantity, :only_integer => true

  validate :quantity_modifier_must_be_an_integer
  validate :not_duplicate
  validate :coherant_quantity

  # Callbacks
  after_initialize :set_default_values
  before_save :compute_quantity
  after_save :delete_me_if_empty

  # Scopes
  def self.deposits_of(asset)
    where(:asset_id => asset.to_param)
  end

  def self.validated( op = true)
    where(:validated => op)
  end

  # Approve a deposit
  def approve
    # Find a validated duplicate.
    stock = Deposit.find_or_new({:user_id => user_id, :asset_id => asset_id, :validated => true})

    stock.quantity_modifier = self.quantity

    stock.save && self.destroy
  end

  # Class method to get the total amount of an asset
  def self.stock(asset)
    validated.deposits_of(asset).sum(:quantity)
  end

  def self.find_or_new(params)
    Deposit.find(:first, :conditions => params) || Deposit.new(params)
  end

  private

  # Default values
  def set_default_values
    self[:quantity] ||= 0
    self.quantity_modifier ||= 0
  end


  # Validation
  def quantity_modifier_must_be_an_integer
    unless self.quantity_modifier.to_i.to_s == self.quantity_modifier.to_s
      errors.add(:quantity, I18n.t('validation.must_be_an_integer'))
    end
  end

  # Validation
  def not_duplicate
    unless Deposit.find(:all, :conditions =>{ :user_id => self.user_id, :asset_id => self.asset_id, :validated => self.validated }).reject {|d| d.id == self.id }.blank?
      errors.add_to_base(I18n.t('deposit.validation.duplicate_is_forbidden'))
    end
  end

  # Validation
  def coherant_quantity
    final_quantity = self.quantity.to_i + self.quantity_modifier.to_i
    potential_user_stock = Deposit.find(:all, :conditions => { :user_id => self.user_id, :asset_id => self.asset_id }).sum(&:quantity)

    if self.validated?
      errors.add_to_base(I18n.t('deposit.validation.stock_cant_be_negative')) if final_quantity < 0
    else
      errors.add_to_base(I18n.t('deposit.validation.withdrawal_cant_be_superior_to_deposits')) if self.quantity_modifier.to_i + potential_user_stock < 0
    end
  end

  # Before save
  def compute_quantity
    self.quantity += self.quantity_modifier.to_i if self.valid?
  end

  # After save
  def delete_me_if_empty
    if self.quantity == 0
      self.destroy
    end
  end

end
