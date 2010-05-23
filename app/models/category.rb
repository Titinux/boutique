class Category < ActiveRecord::Base
  belongs_to :parent,        :class_name => 'Category', :foreign_key => "parent_id"
  has_many   :subCategories, :class_name => 'Category', :foreign_key => "parent_id"

  has_many :assets

  # Scopes
  default_scope :order => :name
  scope :mainCategories, :conditions => { :parent_id => nil }
end
