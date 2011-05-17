class Asset < ActiveRecord::Base
  # Relations
  belongs_to :category
  has_many :deposits
  has_many :order_lines

  # Attributes
  attr_accessible :name, :category_id, :pictureUri, :floatPrice

  attr_searchable  :name
  assoc_searchable :category

  # Validations
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }
  validates_presence_of :category_id

  validates_numericality_of :unitaryPrice, :greater_than_or_equal_to => 0
end
