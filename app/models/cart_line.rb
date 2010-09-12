class CartLine < ActiveRecord::Base
  belongs_to :cart
  belongs_to :asset

  #validates :cart, :presence => true
  validates :asset, :presence => true

  validates_associated :asset

  validates :quantity, :presence => true
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
end
