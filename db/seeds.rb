# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create!(:category_name=>"Celebrity")
Category.create!(:category_name=>"Cars")
Category.create!(:category_name=>"Animals")
Category.create!(:category_name=>"Nature")
Category.create!(:category_name=>"Food")
Category.create!(:category_name=>"Sports")
Category.create!(:category_name=>"Fitness")
Category.create!(:category_name=>"Models")
Category.create!(:category_name=>"Technology")
Category.create!(:category_name=>"Premium")
Category.create!(:category_name=>"Other")
Country.create!(:country_name=>"india")
Country.create!(:country_name=>"America")
Country.create!(:country_name=>"China")
Country.create!(:country_name=>"india")
Country.create!(:country_name=>"india")
Country.create!(:country_name=>"india")
AppConfiguration.create!(config_key: "instagram_access_token", config_value: "4082887215.6b7aae8.d7be357a0346496db3963e55bb06faf4")
AppConfiguration.create!(:config_key=>"mailing url",:config_value=>"http://103.243.5.242:4000/")
AppConfiguration.create!(:config_key=>"mailing url",:config_value=>"http://103.243.5.242:4000/")
