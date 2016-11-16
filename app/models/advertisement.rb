class Advertisement < ActiveRecord::Base

  TYPE = { "link"=>1,"Photo"=> 2, "Video"=>3}
  PLATFORMS = {"Facebook"=>1,"Instagram"=>2, "Both" => 3}
  STATUS = {"Completed" => 1, "Pending" => 0}
end
