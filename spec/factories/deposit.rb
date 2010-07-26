Factory.define :deposit do |f|
  f.association :user, :factory => :user
  f.association :asset, :factory => :asset
  f.quantity 500
  f.validated false
end
