Factory.define :guild do |f|
  f.sequence(:name)  {|n| "guild#{n}" }
end
