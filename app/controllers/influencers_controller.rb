class InfluencersController < ApplicationController
  before_filter :authenticate_influencer!


  def index
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>approved_by_admin)
    @earned_today = today_earning("influencer",current_influencer.id)
    @earned_monthly = monthly_earning("influencer",current_influencer.id)
    @published_ads_count = published_by_influencer_count(current_influencer.id)
    @upcoming_ads = uncoming_ads(current_influencer.id)
  end

  def ad_requests
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>approved_by_admin)
  end

  def ad_history
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id).order("ID DESC")
  end

  def change_password
  end

  def setting
    @new_social_account = SocialAccount.new
    @social_account = current_influencer.social_account
  end

  def add_social_account_details
     if current_influencer.social_account.present?
      flash[:success] = "Social Account Already exists"
    else
      SocialAccount.create!(create_social_account)
      flash[:success] = "Successfully created"
    end
      redirect_to :back
  end

  def update
    Influencer.find(current_influencer).update(update_influencer_params)
    flash[:success] ="updated"
    redirect_to :back
  end

  def profile

  end

  def update_influencer_profile_photo
    upload_image =  Cloudinary::Uploader.upload(params[:influencer_profile_photo])
    current_influencer.update_attributes(:profile_image_url=>upload_image["url"])
    flash[:success] = "Updated"
    redirect_to :back
  end

  private

  def update_influencer_params
    params.require(:influencer).permit!
  end
  def create_social_account
    params.require(:social_account).permit!
  end

end
