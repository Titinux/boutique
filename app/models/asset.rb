class Asset < ActiveRecord::Base
  belongs_to :category
  has_many :deposits
  has_many :order_lines

  # Validations
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }
  validates_presence_of :category_id

  validates_numericality_of :unitaryPrice, :greater_than_or_equal_to => 0

  # Scopes
  default_scope order(:name).includes(:category)
end
