class User < ActiveRecord::Base
  belongs_to :guild
  
  has_many :deposites
  
  #Validations
  validates_length_of :name, :maximum => 25, :allow_blank => false
  validates_uniqueness_of :name
  
  validates_presence_of :guild
  validates_associated :guild
  
  # Callbacks
  after_update :save_deposites
  
  def new_deposite_attributes=(deposite_attributes)
    deposite_attributes.each do |attributes|
      deposites.build(attributes)
    end
  end
  
  def existing_deposite_attributes=(deposite_attributes)
    deposites.reject(&:new_record?).each do |deposite|
      attributes = deposite_attributes[deposite.id.to_s]

      if attributes
        deposite.attributes = attributes
      else
        deposites.delete(deposite)
      end
    end
  end
  
  def save_deposites
    deposites.each do |deposite|
      deposite.save(false)
    end
  end
end
