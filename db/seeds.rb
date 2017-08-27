# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(:email => "simone.stein@gmail.com", :password=>"password")

Category.create(:title => "shirt")
Category.create(:title => "pants")
Category.create(:title => "skirt")
Category.create(:title => "bag")
Category.create(:title => "shoes")
Category.create(:title => "dress")

Season.create(:title=> "Winter")
Season.create(:title=> "Spring")
Season.create(:title=> "Summer")
Season.create(:title=> "Fall")

Item.create(:title => "Black Skirt", :color => "black", :category => Category.find_by(title: "skirt"), :user => User.first)
Item.create(:title => "Red Shirt", :color => "red", :category => Category.find_by(title: "shirt"), :user => User.first)
Item.create(:title => "Blue Dress", :color => "blue", :category => Category.find_by(title: "dress"), :user => User.first)
Item.create(:title => "Blue Shoes", :color => "blue", :category => Category.find_by(title: "shoes"), :user => User.first)




