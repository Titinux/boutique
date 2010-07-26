Factory.define :asset do |f|
  f.sequence(:name)  {|n| "asset#{n}" }
  f.association :category, :factory => :category
  f.unitaryPrice 0.53
  f.floatPrice false
end
