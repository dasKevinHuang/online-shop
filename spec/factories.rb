FactoryGirl.define do
  factory :controller do

  end
  factory :admin do
    encrypted_password { Faker::Commerce.product_name }
    email { "tim@tim.com" }
  end

  factory :user do
    password { "passwordblah" }
    password_confirmation { "passwordblah" }
    email { "blahblah@tim.com" }
  end
  factory :order_item do
    product nil
    order nil
    unit_price "9.99"
    quantity 1
    total_price "9.99"
  end
  factory :order do
    subtotal "9.99"
  end
  factory :order_status do
    name "MyString"
  end


  factory :product do
    title   { Faker::Commerce.product_name }
    details { Faker::Lorem.paragraph }
    price   { Faker::Commerce.price }
    quantity{ Faker::Number.between(1, 10) }
    photo_file_name   { Rails.root + "spec/fixtures/test_nuts.jpg"}
    photo_content_type { 'image/jpg' }
    photo_file_size { 1024 }
  end

end
