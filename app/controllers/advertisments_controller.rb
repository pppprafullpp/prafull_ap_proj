class AdvertismentsController < ApplicationController

  def index
    
  end

  def create
    # raise params.to_yaml
    params[:advertisement][:ad_type] = params[:advertisement][:ad_type].to_s
    new_record = Advertisement.create!(advertisement_params)
    new_record.update_attributes(:status=>Advertisement::STATUS["Initiated"])
      if params[:advertisement][:ad_type].to_s == Advertisement::TYPE["Photo"].to_s
         upload_image =  Cloudinary::Uploader.upload(params[:advertisement][:ad_image_url])
        new_record.update_attributes(:ad_image_url=>upload_image["url"])
      end
      ApplicationController.new.add_notification(Notification::ACTIVITY_TYPE["new_ad_creation"],"New Ad created",:viewed=>false)
      PendingNotification.create!(
      influencer_id:new_record.influencer_id,
      advertiser_id:new_record.advertiser_id,
      notification_type:Advertisement::STATUS["Initiated"],
      notification_text:Advertisement::STATUS_TEXT[Advertisement::STATUS["Initiated"]-1],
      advertisement_id:new_record.id,
      :viewed=>false)
    flash[:success] = "Created successfully"
    redirect_to :back
  end

  def update_ad_share_url_and_status
    advertisement = Advertisement.find(params[:id])
    if advertisement.platform ==  Advertisement::PLATFORMS["Facebook"]
      prefix = "http://facebook.com/"
    else
      prefix = "http://instagram.com/"
    end
    Advertisement.find(params[:id]).update_attributes(:advertisement_link=>prefix+params[:post_id], :status=>Advertisement::STATUS["Published by influencer"])
    influencer_name = Influencer.find(Advertisement.find(params[:id]).influencer_id).name
    ApplicationController.new.add_notification(Notification::ACTIVITY_TYPE["new_ad_published"],"New Ad published by #{influencer_name}",:viewed=>false)
    render :json => {
      success:true
    }
  end


  def ad_declined_by_influencer
    update_advertisement = Advertisement.find(params[:ad_id]).update_attributes(:status=>declined_by_influencer,:reason_for_decline=>params[:reason_for_decline])
    if update_advertisement
      response = true
    else
      response = false
    end
    render :json => {
      success:response
    }
  end

private

  def advertisement_params
    params.require(:advertisement).permit!
  end

end
