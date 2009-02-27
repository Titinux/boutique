class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :asset
  
  def price
    quantity * unitaryPrice
  end
end
