Factory.define :category do |f|
  f.sequence(:name)  {|n| "category#{n}" }
end
