# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#merhcant storefronts
megan_shop = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian_shop = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

#users
user1 = User.create(name: 'User1', address: '1234 User St.', city: 'Denver', state: 'CO', zip: '80144', email: 'user@email.com', password: 'password', password_confirmation: 'password')
user2 = User.create(name: 'User2', address: '1234 User St.', city: 'Denver', state: 'CO', zip: '80144', email: 'user2@email.com', password: 'password', password_confirmation: 'password')
user3 = User.create(name: 'User3', address: '1234 User St.', city: 'Denver', state: 'CO', zip: '80144', email: 'user3@email.com', password: 'password', password_confirmation: 'password')

merchant = User.create(name: 'Merchant Megan', address: '411 Merchant St.', city: 'Denver', state: 'CO', zip: '80144', role: 1, email: 'merchant@email.com', password: 'password', password_confirmation: 'password')
megan_shop.users << merchant

merchant_brian = User.create(name: 'Merchant Brian', address: '114 Merchant St.', city: 'Denver', state: 'CO', zip: '80134', role: 1, email: 'merchant_brian@email.com', password: 'password', password_confirmation: 'password')
brian_shop.users << merchant_brian

admin = User.create(name: 'Benny', address: '101 Admin St.', city: 'Denver', state: 'CO', zip: '80144', role: 2, email: 'admin@email.com', password: 'password', password_confirmation: 'password')

#megans items
megan_shop.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan_shop.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

#brians items
brian_shop.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

#discounts
five_percent = megan_shop.discounts.create!(name: "5% Discount", description: "This discount applies once item quantity reaches 5 and remains until quantity reaches 10.", discount_amt: 0.05, req_qty: 5)
ten_percent = megan_shop.discounts.create!(name: "10% Discount", description: "This discount applies once item quantity reaches 10 and remains until quantity reaches 15.", discount_amt: 0.1, req_qty: 5)

seven_percent = brian_shop.discounts.create!(name: "7% Discount", description: "This discount applies once item quantity reaches 7 and remains until quantity reaches 17.", discount_amt: 0.07, req_qty: 7)
eleven_percent = brian_shop.discounts.create!(name: "11% Discount", description: "This discount applies once item quantity reaches 11 and remains until quantity reaches 21.", discount_amt: 0.11, req_qty: 11)

