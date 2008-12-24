class Category < ActiveRecord::Base
  belongs_to :parent,        :class_name => 'Category', :foreign_key => "parent_id"
  has_many   :subCategories, :class_name => 'Category', :foreign_key => "parent_id"

  has_many :assets
  
  named_scope :mainCategories, :conditions => { :parent_id => nil }
end
