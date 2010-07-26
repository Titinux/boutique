Factory.define :administrator do |f|
  f.sequence(:name)  {|n| "admin#{n}" }
  f.email  {|a| "#{a.name}@example.com" }

  f.password "admin_password"
  f.password_confirmation {|a| a.password }
end
