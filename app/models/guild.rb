class Guild < ActiveRecord::Base
  
  # Associations
  has_many :users
  
  # Scopes
  default_scope :order => 'name'

end
