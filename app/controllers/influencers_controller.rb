class InfluencersController < ApplicationController
  before_filter :authenticate_influencer!
  before_filter :check_if_influencer_completed_wizard

  def check_if_influencer_completed_wizard
    true
  end

  def index
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>approved_by_admin).limit(3)
    @earned_today = today_earning("influencer",current_influencer.id)
    @earned_monthly = monthly_earning("influencer",current_influencer.id)
    @published_ads_count = published_by_influencer_count(current_influencer.id)
    @upcoming_ads = uncoming_ads(current_influencer.id)
    @total_spent = spent_total("influencer",current_influencer.id)
  end

  def ad_requests
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>approved_by_admin)
  end

  def ad_history
    status = params[:status].present? ? params[:status].to_i : 6
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>status).order("ID DESC")
  end

  def insights
    @social_accounts = current_influencer.social_accounts.order("ID DESC")
    @instagram_followers = current_influencer.instagram_page_count
    @influencer_details = current_influencer
    @token =  AppConfiguration.find_by(:config_key=>"instagram_access_token").config_value
    @image_urls = []
    if current_influencer.instagram_id.present?
      instagram_token = AppConfiguration.find_by(:config_key=>"instagram_access_token").config_value
      instagram_id = current_influencer.instagram_id
      puts "?????????????????????????????????????????>>>>>>>>>>>>>>>>>>>>#{instagram_id}"
      request_url = HTTParty.get("https://api.instagram.com/v1/users/"+current_influencer.instagram_id+"/media/recent?access_token="+instagram_token)
      request_url["data"].each_with_index do |r,index|
        @image_urls <<  r["images"]["standard_resolution"]["url"]
      end
      self_data = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/?access_token=#{@token}")["data"]["counts"]
      @following = self_data["follows"]
      @followed_by = self_data["followed_by"]
      total_likes_object = HTTParty.get("https://api.instagram.com/v1/users/#{instagram_id}/media/recent/?access_token=#{@token}")["data"]
      total_object_length = total_likes_object.length
      likes_sum = 0
      comment_sum =0
      total_likes_object.each do |object|
        likes_sum = likes_sum + object["likes"]["count"]
        comment_sum = comment_sum + object["comments"]["count"]
      end
      @average_of_likes = likes_sum/total_object_length
      @average_of_comments = comment_sum/total_object_length
end
  end

  def change_password
  end

  def setting
    # @new_social_account = current_influencer.social_accounts || current_influencer.social_accounts.new
    @social_accounts = current_influencer.social_accounts
  end

  # elements:
  #   facebook_page_id: '690894611085161'
  #   facebook_page_likes: '1'
  #   controller: influencers
  #   action: add_social_account_details
  #   influencer_id: '9'

  def add_social_account_details
      if SocialAccount.find_by_facebook_page_id(params[:facebook_page_id])
          SocialAccount.find_by_facebook_page_id(params[:facebook_page_id])
          .update_attributes(
          :facebook_page_id=>params[:facebook_page_id],
          :facebook_page_count=>params[:facebook_page_likes],
          :influencer_id=>current_influencer.id,
          :facebook_page_title=>params[:page_name])
          puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>updated"
      else
        SocialAccount.create!(
        :facebook_page_id=>params[:facebook_page_id],
        :facebook_page_count=>params[:facebook_page_likes],
        :influencer_id=>current_influencer.id,
        :facebook_page_title=>params[:page_name])
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>created"
      end
      render :json=>{
      :status=>"updated",
      :code=>200
      }

    #  if current_influencer.social_account.present?
    #   current_influencer.social_account.update_attributes(:facebook_page_id=>params[:social_account][:facebook_page_id])
    #   flash[:success] = "Social Account Updated, Data from Facebook will be pulled in 24 hours"
    # else
    #   SocialAccount.create!(create_social_account)
    #   flash[:success] = "Successfully created, Data from Facebook will be pulled in 24 hours"
    # end
    #   redirect_to :back
  end

  def add_instagram_followers
     current_influencer.update_attributes(:instagram_page_count=>params[:followers],:instagram_id=>params[:instagram_id])
      render :json=>{
        :status => "updated",
        :code => 200
      }
  end

  def update
    Influencer.find(current_influencer).update(update_influencer_params)
    flash[:success] ="updated"
    redirect_to :back
  end

  def profile
    @financial_data = current_influencer.influencer_financial_info.present? ? current_influencer.influencer_financial_info : InfluencerFinancialInfo.new
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
