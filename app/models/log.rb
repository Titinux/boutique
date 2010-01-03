class Log < ActiveRecord::Base
  # Validations
  validates_presence_of :level, :user, :action, :objectType, :objectId

  #
  serialize :data

  # Scopes
  default_scope :order => 'id DESC'
end
