# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# category = Category.create(:name=>"Celebrity")
# category = Category.create(:name=>"Cars")
# category = Category.create(:name=>"Animals")
# category = Category.create(:name=>"Nature")
# category = Category.create(:name=>"Food")
# category = Category.create(:name=>"Sports")
# category = Category.create(:name=>"Fitness")
# category = Category.create(:name=>"Models")
# category = Category.create(:name=>"Technology")
# category = Category.create(:name=>"Premium")
# category = Category.create(:name=>"Other")
AppConfiguration.create!(:config_key=>"mailing url",:config_value=>"http://103.243.5.242:4000/")
