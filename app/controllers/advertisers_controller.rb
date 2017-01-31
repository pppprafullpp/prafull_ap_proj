class AdvertisersController < ApplicationController

  before_filter :authenticate_advertiser!, :except =>[:new, :create]
  before_filter :check_if_verified

  def check_if_verified
    if !current_advertiser.is_verified
      reset_session
      flash[:notice] = "please verify your id"
      redirect_to root_path
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
     @social_account = @influencer_details.social_account
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
