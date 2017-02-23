class AdvertisersController < ApplicationController
  include HTTParty
  require 'rest-client'
  require 'net/http'

  before_filter :authenticate_advertiser!, :except =>[:new, :create]
  before_filter :check_if_verified

  def check_if_verified
    if !current_advertiser.is_verified
      reset_session
      flash[:notice] = "please verify your id"
      redirect_to root_path
    end
   end

   def show_demographic
     if params[:instagram_id].present?
       url = "https://www.demographicspro.com/6/api/get_codes?get_audience_reach_analysis?for="+params[:instagram_id]+"&data=followers_of_id&network=instagram"
       puts url
       request = RestClient::Request.execute method: :get, url: url, user: 'socialbooker_apitest', password: '2vi8dtmsii3c'
       request = JSON.parse(request)
       @male_reach = request["sections_list"][0]["section_content"][0]["i_average"]
       @female_reach = request["sections_list"][0]["section_content"][1]["i_average"]
       @country_reach = request["sections_list"][8]["section_content"]
       @top_5_countries_in_reach = @country_reach.sort_by {|h| h["i_average"]}.reverse.first(5)
       @top_5_countries_in_reach = @top_5_countries_in_reach.map{|f| f["name"]+","+f["i_average"].to_s}
       @token =  AppConfiguration.find_by(:config_key=>"instagram_access_token").config_value
       instagram_url = "https://api.instagram.com/v1/users/"+params[:instagram_id]+"/?access_token=#{@token}"
       ig_request = HTTParty.get(instagram_url)
       @name = ig_request["data"]["full_name"]
       @ig_link = "http://instagram.com/"+ig_request["data"]["username"]
     end
   end


   def show_influencers
      if params[:publishing_price].present? && params[:category].present?
         @influencers = Influencer.where(:publishing_price=>params[:publishing_price],:category_id=>params[:category])
       elsif params[:category].present?
         @influencers = Influencer.where(:category_id=>params[:category])
       elsif params[:publishing_price].present?
         @influencers = Influencer.where(:publishing_price=>params[:publishing_price])
       else
          @influencers = Influencer.all
     end
     @influencers = @influencers.order("name ASC").paginate(:page=>params[:page],:per_page=>10)
   end

   def update_advertiser_profile_photo
     upload_image =  Cloudinary::Uploader.upload(params[:advertiser_profile_photo])
     current_advertiser.update_attributes(:profile_photo_url=>upload_image["url"])
     flash[:success] = "Updated"
     redirect_to :back
   end

  def index
    @current_advertisers_data = current_advertiser
    @advertisers_ad = current_advertiser.advertisements.order("updated_at DESC").paginate(:page=>params[:page],:per_page=> 10)
    @spent_today = spent_today("advertiser",current_advertiser.id)
    @spent_this_month = spent_monthly("advertiser",current_advertiser.id)
    @published_ad_count = published_ad_count(current_advertiser.id)
    @influencer_count = Influencer.count
    @total_spent = spent_total("advertiser",current_advertiser.id)
   end

  def my_wallet
    @wallet_amount = current_advertiser.wallet_amount
  end

  def create_audience_group
      length = params[:influencer_group][:influencer_id].length
      new_group = GroupMapping.create!(advertiser_id:current_advertiser.id,group_name:params[:influencer_group][:group_name])
      rows = params[:influencer_group][:influencer_id]
      current_advertiser_id = current_advertiser.id
      rows.each do |influencer_id|
        InfluencerGroup.create!(advertiser_id: current_advertiser_id, influencer_id:influencer_id, group_name:new_group.group_name,
        category_id: params[:influencer_group][:category_id],group_mapping_id:new_group.id) if influencer_id.present?
      end
       redirect_to :back
  end

  def new
    @new_advertiser = Advertiser.new
  end

  def create
    Advertiser.create!(advertiser_params)
    flash[:success] = "Successfully Registered, Please Login"
    redirect_to "/advertisers"
  end

  def social_accounts
    params[:social_account] = {} unless params[:social_account].present?
    @search = SocialAccount.new
    @social_accounts = SocialAccount.search(params[:social_account])
  end

  def destroy_group
    GroupMapping.find(params[:id]).destroy
    render :json => {
      success:true
    }
  end

  def ad_compaigns
    @ads = Advertisement.where(:advertiser_id=>current_advertiser.id).order("Id DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def audience_management
    @new_group = InfluencerGroup.new
    @all_groups = current_advertiser.group_mappings
  end

  def setting

  end

  def influencer_detail
    @social_account_detail = SocialAccount.find(params[:social_account_id])
  end

  def create_ad_compaign
    @new_advertisment = Advertisement.new
  end

  def change_password
    if current_advertiser.valid_password?(params[:advertiser][:old_password])
      current_advertiser.update_attributes(:password=> params[:advertiser][:password])
      flash[:alert] = "Changed"
      redirect_to :back
     else
      flash[:error] = "Wrong Old Password"
      redirect_to :back
     end
   end

   def profile

   end

   def get_wallet_status
     wallet_amount = Advertiser.find(params[:id]).wallet_amount.to_i
     publishing_price = Influencer.find(params[:influencer_id]).publishing_price.to_i
     if wallet_amount >= publishing_price
       success = true
     else
       success = false
     end
     render :json => {
       success:success,
       wallet_amount:wallet_amount,
       publishing_price:publishing_price
     }
   end

   def show_influencer_details
     @influencer_details = Influencer.find(params[:id])
     @social_accounts = @influencer_details.social_accounts
     instagram_id = @influencer_details.instagram_id
     @token =  AppConfiguration.find_by(:config_key=>"instagram_access_token").config_value
     @image_urls = []
     if instagram_id.present?
       puts "?????????????????????????????????????????>>>>>>>>>>>>>>>>>>>>#{instagram_id}"
       instagram_token = AppConfiguration.find_by(:config_key=>"instagram_access_token").config_value
       request_url = HTTParty.get("https://api.instagram.com/v1/users/"+instagram_id+"/media/recent?access_token="+instagram_token)
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
       if total_object_length > 0
         @average_of_likes = likes_sum/total_object_length
         @average_of_comments = comment_sum/total_object_length
       else
         @average_of_likes = 0
         @average_of_comments = 0
      end
      #  byebug
      #  request_url = HTTParty.get(("https://api.instagram.com/v1/users/1581592650/?access_token=4082887215.6b7aae8.d7be357a0346496db3963e55bb06faf4"))
      #  data = r["images"]["standard_resolution"]
     end

    end

   def group_details
     @group_details = GroupMapping.find(params[:id])
     @member_data = GroupMapping.find(params[:id]).influencer_groups
   end

   def delete_group_member
     InfluencerGroup.find(params[:id]).destroy
     render :json=> {
       success:true
     }
   end

   def check_existing_group
     search = GroupMapping.find_by_group_name(params[:name])
     if search
       present = true
     else
       present = false
     end
     render :json=>{
       status:present
     }
   end

   def add_member_to_existing_group
   end

  private

  def advertiser_params
    params.require(:advertiser).permit!
  end

end
