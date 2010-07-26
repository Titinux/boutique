class Guild < ActiveRecord::Base

  # Associations
  has_many :users

  # Validation
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }

  # Scopes
  default_scope :order => 'name'

end
