class Advertisement < ActiveRecord::Base

  TYPE = { "Link"=>1,"Photo"=> 2, "Video"=>3}
  PLATFORMS = {"Facebook"=>1}

  STATUS =  {"Initiated" => 1,"Approved by Admin" => 2,"Approved by influencer" => 3,"Declined by Admin" => 4, "Declined by influencer"=>5,"Published by influencer"=>6}
  STATUS_TEXT = ["A new Advertisement for You","Advertisement Approved By Admin","Advertisement Approved By Influencer","Advertisement Declined By Admin","Declined By Influencer","Published By Influencer"]

  has_many :advertisements
  # has_one :transaction
end
