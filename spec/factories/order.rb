Factory.define :order do |o|
  o.association :user, :factory => :user
  o.state 'WAIT_ESTIMATE'

  o.lines {|l| [Factory.build(:order_line)]}
end

Factory.define :estimated_order, :parent => :order do |o|
  o.state 'WAIT_ESTIMATE_VALIDATION'
  o.lines do |l|
    [
      Factory.build(:estimated_order_line),
      Factory.build(:estimated_order_line)
    ]
  end
end

Factory.define :in_preparation_order, :parent => :estimated_order do |o|
  o.state 'IN_PREPARATION'
end

Factory.define :canceled_order, :parent => :estimated_order do |o|
  o.state 'ORDER_CANCELED'
end

Factory.define :ready_order, :parent => :estimated_order do |o|
  o.state 'WAIT_DELIVERY'
end

Factory.define :achieved_order, :parent => :estimated_order do |o|
  o.state 'ACHIEVED'
end
