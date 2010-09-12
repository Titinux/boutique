class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :lines, :class_name => 'CartLine', :dependent => :destroy

  # Validations
  validates :user_id, :presence => true
  validates_associated :user

  validates :name, :presence => true,
            :length => {:minimum => 2, :maximum => 30},
            :unless => Proc.new { self.current? }

  validates_uniqueness_of :name, :scope => [:user_id]

  # Nested attributes
  accepts_nested_attributes_for :lines, :allow_destroy => true

  def copy_lines_to(dest_cart)
    self.lines.each do |line|
      dest_cart.lines.build(line.attributes)
    end

    dest_cart.save
  end

  def to_order()
    order = Order.new({ :user => self.user, :state => 'WAIT_ESTIMATE'})

    lines.each do |line|
      order.lines.build({:asset_id => line.asset_id, :quantity => line.quantity, :unitaryPrice => 0})
    end

    order.save
  end
end
