# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_names = [{name: 'João', email: 'joao@test.com'}, {name: 'Diogo', email: 'diogo@test.com'}]

product_details = [{name: 'Learn RoR - Beginner', price: 24.99}, {name:'Mastering RoR - Level over 9000', price: 9001.00}]

user_names.each do |user|
  User.create(name: user[:name], password: 'test123', email: user[:email])
end

product_details.each do |product|
  Product.create(name: product[:name], price: product[:price])
end
