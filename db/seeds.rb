require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
Relationship.delete_all
Category.delete_all

4.times do
  category = Category.create(
    title:        Faker::Commerce.product_name,
    description:  Faker::Lorem.paragraph,
    image_url:    Faker::Avatar.image
    )
end

4.times do
  product = Product.create(
    title:    Faker::Commerce.product_name,
    price:    Faker::Commerce.price,
    details:  Faker::Lorem.paragraph,
    photo:    File.open("#{Rails.root}/spec/images/test_nuts.jpg"),
    quantity: Faker::Number.between(1, 10)
    )  
end

4.times do
  product = Product.all.sample
  category = Category.all.sample
  product.categories << category
end


Admin.delete_all
  
  password = "timtim"
  new_hashed_password = Admin.new(:password => password).encrypted_password

  admin = Admin.create!(
    email:    "tim@tim.com",
    encrypted_password: new_hashed_password
    )

User.delete_all
  
  password = "tomtom"
  password_confirmation = "tomtom"
  new_hashed_password = User.new(:password => password).encrypted_password

  user = User.create!(
    email:    "tom@tom.com",
    password: password,
    password_confirmation: password_confirmation
    )
