Factory.define :cart_line do |f|
  f.association :cart,  :factory => :cart
  f.association :asset, :factory => :asset
  f.quantity 42
end

