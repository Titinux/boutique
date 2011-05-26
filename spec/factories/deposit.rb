Factory.define :deposit do |f|
  f.association :user, :factory => :user
  f.association :asset, :factory => :asset
  f.quantity_modifier 500
  f.validated false
end
