class Guild < ActiveRecord::Base

  # Associations
  has_many :users

  # Attributes
  attr_accessible :name, :pictureUri
  attr_searchable :name

  # Validation
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }
end
