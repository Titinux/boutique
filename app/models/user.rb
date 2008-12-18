class User < ActiveRecord::Base
  belongs_to :guild
  
  #Validations
  validates_length_of :name, :maximum => 25, :allow_blank => false
  validates_uniqueness_of :name
  
  validates_presence_of :guild
  validates_associated :guild
end
