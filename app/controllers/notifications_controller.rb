class NotificationsController < ApplicationController

  def get_pending_notification
    # raise params.to_yaml
    # eval(params[:current_user_type].camelcase).find(params[:id])
    if params[:current_user_type] == "influencer"
      pending_notifications = PendingNotification.where(:influencer_id=>params[:id],:viewed=>false)
      # PendingNotification.where(:influencer_id => params[:id]).update_all(:viewed=>true )
    else
      pending_notifications = PendingNotification.where(:advertiser_id=>params[:id],:viewed=>false)
      # PendingNotification.where(:advertiser_id => params[:id]).update_all(:viewed=>true )
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
