class Category < ActiveRecord::Base
  validates_uniqueness_of :category_name
end
