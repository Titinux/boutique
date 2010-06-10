class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :asset

  #validates :order_id, :presence => true

  validates :asset_id, :presence => true
  validates_associated :asset

  validates :quantity, :presence => true, :numericality => true

  def price
    quantity * (unitaryPrice || 0)
  end
end
