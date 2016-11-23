class Advertisement < ActiveRecord::Base

  TYPE = { "Link"=>1,"Photo"=> 2, "Video"=>3}
  PLATFORMS = {"Facebook"=>1,"Instagram"=>2, "Both" => 3}
  STATUS =  {"Initiated" => 1,"Approved by Admin" => 2,"Approved by influncer" => 3,"Declined by Admin" => 4, "declined_by influencer"=>5}
end
