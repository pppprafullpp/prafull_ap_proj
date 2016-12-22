class Advertisement < ActiveRecord::Base

  TYPE = { "Link"=>1,"Photo"=> 2, "Video"=>3}
  PLATFORMS = {"Facebook"=>1,"Instagram"=>2, "Both" => 3}

  STATUS =  {"Initiated" => 1,"Approved by Admin" => 2,"Approved by influencer" => 3,"Declined by Admin" => 4, "Declined by influencer"=>5,"Published by influencer"=>6}
  STATUS_TEXT = ["Created a new Advertisement","Advertisement Approved By Admin","Advertisement Approved By Influencer","Advertisement Declined By Admin","Declined By Influencer","Published By Influencer"]

  has_many :advertisements

  # after_save :update_notification
  #
  # def update_notification
  #   ApplicationController.new.add_notification(Notification::ACTIVITY_TYPE["new_ad_creation"],"new ad created",:viewed=>false)
  # end
end
