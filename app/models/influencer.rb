class Influencer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  PLATFORMS = {"Facebook"=>1 }
  GENDERS = {"MALE"=>1,"FEMALE"=>2}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_one :social_account
    has_one :influencer_financial_info
    has_many :advertisements
    # after_save :update_notification
    def update_notification
      ApplicationController.new.add_notification(Notification::ACTIVITY_TYPE["influencer_sign_up"],"#{self.name} signed up as influencer",:viewed=>false)
    end

end
