class Category < ActiveRecord::Base
  # Relations
  belongs_to :parent,        :class_name => 'Category', :foreign_key => "parent_id"
  has_many   :subCategories, :class_name => 'Category', :foreign_key => "parent_id"

  has_many :assets

  # Attributes
  attr_accessible :name, :parent_id, :pictureUri
  attr_searchable :name

  # Validations
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }

  # Scopes
  scope :mainCategories, where(:parent_id => nil)
end
