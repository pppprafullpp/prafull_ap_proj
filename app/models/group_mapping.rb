class GroupMapping < ActiveRecord::Base
  has_many :influencer_groups,dependent: :destroy
  validates_uniqueness_of :group_name
end
