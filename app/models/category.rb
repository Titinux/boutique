class Category < ActiveRecord::Base
  belongs_to :parent,        :class_name => 'Category', :foreign_key => "parent_id"
  has_many   :subCategories, :class_name => 'Category', :foreign_key => "parent_id"

  has_many :assets

  # Validations
  validates :name, :uniqueness => true, :presence => true, :length => { :within => 2..25 }

  # Scopes
  default_scope order(:name)
  scope :mainCategories, where(:parent_id => nil)
end
