10.times do |i|
  User.create!(user_name:"user_#{i}", email: Faker::Internet.email,
  password: "123456", password_confirmation: "123456", is_admin: false)
end

Category.create!(name: "Electronics",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Women's Fashion",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Men's Fashion",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Home & Living",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Health & Beauty",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Baby & Toys",
  description: Faker::Lorem.sentence(3, false, 4))

SubCategory.create!(name: "Mobiles & Tablets", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Computers & Laptops", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Cameras", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))

4.times do |i|
  Classification.create(name: "Classification_#{i}",
    description: Faker::Lorem.sentence(3, false, 4))
end
classifications = Classification.all
categories = Category.all
categories.each do |category|
  SubCategory.create!(name: "sub_#{category.name}",category: category ,
    description: Faker::Lorem.sentence(3, false, 4))
end

sub_categories = SubCategory.all

sub_categories.each do |sub_category|

  10.times do |i|
    Product.create!(sub_category: sub_category,
      classification: classifications.first,
      name: "#{sub_category.name}_#{i}",price: 1000, quantity: 100,
      image: open("public/uploads/user/profile_image/24/photo-1453365607868-7deed8cc7d26.jpg"),
      description: Faker::Lorem.sentence(3, false, 4))
  end
end

10.times do |i|
  Comment.create(user: User.first, product: Product.find(2),
    content: Faker::Lorem.sentence(3, false, 4))
end
10.times do |i|
  Rating.create!(user: User.find(2), product: Product.first, point: i)
end

3.times do |i|
  OrderStatus.create!(name: "Status_#{i}",
    description: Faker::Lorem.sentence(3, false, 4))
end
 users = User.all

 users.each do |user|
   Order.create!(user: user, order_status: OrderStatus.find(2),
    address: Faker::Address.street_address,
    full_name: Faker::Name.name_with_middle,
    phone: Faker::PhoneNumber.cell_phone)
 end

orders = Order.all

orders.each do |order|
  OrderDetail.create!(product: Product.find(2), order: order, quantity: 3,
    price: 1000)
end
