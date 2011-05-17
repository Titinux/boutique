class Guild < ActiveRecord::Base

  # Associations
  has_many :users

  # Attributes
  attr_searchable :name

  # Validation
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }

  # Scopes
  default_scope :order => 'name'
end
