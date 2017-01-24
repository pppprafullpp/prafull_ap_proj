class Advertiser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
     has_many :advertisements
     has_many :group_mappings, dependent: :destroy
    after_save :update_notification

    def update_notification
      ApplicationController.new.add_notification(Notification::ACTIVITY_TYPE["advertiser_sign_up"],"#{self.name} signed up as influencer",:viewed=>false)
    end

    def self.verify(id)
      self.find(id).update_attributes(:is_verified=>true)
    end

end
