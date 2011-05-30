Factory.define :order_line do |ol|
  #ol.association :order, :factory => :order
  ol.association :asset, :factory => :asset

  ol.quantity { rand(500)+1 }
end

Factory.define :estimated_order_line, :parent => :order_line do |ol|
  ol.unitaryPrice { rand(250)+1 }
end
