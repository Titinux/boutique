Factory.define :user do |f|
  f.sequence(:name)  {|n| "user#{n}" }
  f.email  {|a| "#{a.name}@example.com" }

  f.password "user_password"
  f.password_confirmation {|a| a.password }
end

Factory.define :gatherer, :parent => :user do |f|
  f.gatherer true
end
