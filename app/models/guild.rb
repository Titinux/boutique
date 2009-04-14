class Guild < ActiveRecord::Base
  
  # Scopes
  default_scope :order => 'name'

end
