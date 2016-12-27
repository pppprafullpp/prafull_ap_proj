class NotificationsController < ApplicationController
  # STATUS =  {"Initiated" => 1,"Approved by Admin" => 2,"Approved by influencer" => 3,"Declined by Admin" => 4, "Declined by influencer"=>5,"Published by influencer"=>6}

  def get_pending_notification
    if params[:current_user_type] == "influencer"
      pending_notifications = PendingNotification.find_by_sql("SELECT * FROM pending_notifications WHERE influencer_id = #{params[:id]} and notification_type = 2 and viewed=false ORDER BY ID DESC")
    else
       pending_notifications = PendingNotification.find_by_sql("SELECT * FROM pending_notifications WHERE advertiser_id=#{params[:id]} and viewed=false and notification_type IN (2,3,45,6) ORDER BY ID DESC")
    end
    render :json =>{
      success:true,
      pending_notifications:pending_notifications
    }
  end

  def reset_pending_notification
    PendingNotification.find(params[:row_id]).update(:viewed=>true)
    render :json =>{
      success:true,
    }
  end
end
