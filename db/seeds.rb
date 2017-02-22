# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Category.create!(:name=>"Celebrity")
# Category.create!(:name=>"Cars")
# Category.create!(:name=>"Animals")
# Category.create!(:name=>"Nature")
# Category.create!(:name=>"Food")
# Category.create!(:name=>"Sports")
# Category.create!(:name=>"Fitness")
# Category.create!(:name=>"Models")
# Category.create!(:name=>"Technology")
# Category.create!(:name=>"Premium")
# Category.create!(:name=>"Other")
Country.create!(:country_name=>"india")
Country.create!(:country_name=>"America")
Country.create!(:country_name=>"China")
AppConfiguration.create!(config_key: "instagram_access_token", config_value: "4082887215.6b7aae8.d7be357a0346496db3963e55bb06faf4")
AppConfiguration.create!(:config_key=>"mailing url",:config_value=>"http://103.243.5.242:4000/")
# AppConfiguration.create!(:config_key=>"mailing url",:config_value=>"http://103.243.5.242:4000/")
# Country.create!(:country_name=>"india")
# Country.create!(:country_name=>"india")
# Country.create!(:country_name=>"india")
