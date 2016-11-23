class AdvertismentsController < ApplicationController

  def create
    # raise params.to_yaml
    byebug
    params[:advertisement][:ad_type] = params[:advertisement][:ad_type].to_s
    new_record = Advertisement.create!(advertisement_params)
    new_record.update_attributes(:status=>Advertisement::STATUS["Initiated"])
      if params[:ad_type].to_s == Advertisement::TYPE["Photo"].to_s
         upload_image =  Cloudinary::Uploader.upload(params[:advertisement][:ad_image_url])
        new_record.update_attributes(:ad_image_url=>upload_image["url"])
      end
    flash[:success] = "Created successfully"
    redirect_to :back
  end

private

  def advertisement_params
    params.require(:advertisement).permit!
  end

end
