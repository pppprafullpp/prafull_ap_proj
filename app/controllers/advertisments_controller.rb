class AdvertismentsController < ApplicationController

  def index
    @advertisement = Advertisement.find(params[:advertisement_id])
    PendingNotification.find(params[:pn_id]).update_attributes(:viewed=>true)
  end

  def show

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

    Transaction.create!(
    :advertisement_id=>new_record.id,
    :influencer_id=>new_record.influencer_id,
    :advertiser_id=>new_record.advertiser_id,
    :status=>new_record.status,
    :amount=>params[:advertisement_cost])
    flash[:success] = "Ad created , you will be charged when you ad goes live"
    redirect_to advertiser_ad_compaigns_path(advertiser_id:current_advertiser.id)
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

    advertiser = Advertiser.find(advertisement.advertiser_id)

    current_wallet_amount = advertiser.wallet_amount

    advertisement_cost = Transaction.find_by_advertisement_id(advertisement.id).amount

    new_wallet_amount = current_wallet_amount - advertisement_cost.to_i;

    advertiser.update_attributes(:wallet_amount=>new_wallet_amount)

    PendingNotification.create!(
    influencer_id:advertisement.influencer_id,
    advertiser_id:advertisement.advertiser_id,
    notification_type:Advertisement::STATUS["Published by influencer"],
    notification_text:Advertisement::STATUS_TEXT[Advertisement::STATUS["Published by influencer"]-1],
    advertisement_id:advertisement.id,
    :viewed=>false)

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
