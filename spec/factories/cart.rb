Factory.define :current_cart, :class => Cart do |f|
  f.association :user, :factory => :user
  f.current true
end

Factory.define :cart, :parent => :current_cart do |f|
  f.sequence(:name)  {|n| "cart#{n}" }
  f.current false
end
