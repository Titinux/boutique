class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :orderLines
  
  named_scope :ongoing, :conditions => ["state < 4"]
  
  # Callbacks
  after_update :save_lines
  
  def new_line_attributes=(line_attributes)
    line_attributes.each do |attributes|
      orderLines.build(attributes)
    end
  end
  
  def existing_line_attributes=(line_attributes)
    orderLines.reject(&:new_record?).each do |line|
      attributes = line_attributes[line.id.to_s]

      if attributes
        line.attributes = attributes
      else
        orderLines.delete(line)
      end
    end
  end
  
  def save_lines
    orderLines.each do |line|
      line.save(false)
    end
  end
end
