class Log < ActiveRecord::Base
  # Validations
  validates_presence_of :level, :user, :action, :objectType, :objectId

  # Attributes
  attr_searchable  :id, :user, :action, :objectType, :objectId, :created_at

  #
  serialize :data
end
