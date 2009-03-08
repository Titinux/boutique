class Asset < ActiveRecord::Base
  belongs_to :category
  has_many :deposites
  has_many :order_lines
end
