# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Daley', city: cities.first)

if Rails.env == 'development'
  if Administrator.count == 0
    Administrator.create! name: 'administrator', email: 'admin@example.com', password: 'administrator', password_confirmation: 'administrator'
  end

  if Category.count == 0
    (1..10).each do |c|
      cat = Category.create! name: "Category #{c}"

      rand(10).times do |sc|
        subcat = Category.create! name: "Category #{c}-#{sc}", parent_id: cat.id

        rand(100).times do |p|
          Asset.create! name: "Asset #{c}-#{sc} #{p}", category_id: subcat.id
        end
      end
    end
  end
end
