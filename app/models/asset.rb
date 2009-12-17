class Asset < ActiveRecord::Base
  belongs_to :category
  has_many :deposits
  has_many :order_lines

  # Constraints
  validates_presence_of :name
  validates_length_of :name, :maximum => 25
  validates_uniqueness_of :name

  validates_presence_of :category_id

  validates_numericality_of :unitaryPrice

  # Scopes
  default_scope :order => :name, :include => :category
end
