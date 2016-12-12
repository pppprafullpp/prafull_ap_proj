class AdvertismentsController < ApplicationController

  def create
    # raise params.to_yaml
    params[:advertisement][:ad_type] = params[:advertisement][:ad_type].to_s
    new_record = Advertisement.create!(advertisement_params)
    new_record.update_attributes(:status=>Advertisement::STATUS["Initiated"])
      if params[:advertisement][:ad_type].to_s == Advertisement::TYPE["Photo"].to_s
         upload_image =  Cloudinary::Uploader.upload(params[:advertisement][:ad_image_url])
        new_record.update_attributes(:ad_image_url=>upload_image["url"])
      end
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
