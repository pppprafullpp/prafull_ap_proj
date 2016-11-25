class AdvertisersController < ApplicationController

  before_filter :authenticate_advertiser!, :except =>[:new, :create]

  def index

    @current_advertisers_data = current_advertiser
    @advertisers_ad = current_advertiser.advertisements
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

  def ad_compaigns
    @ads = Advertisement.all.paginate(:page => params[:page], :per_page => 10)
  end

  def audience_management

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
  private

  def advertiser_params
    params.require(:advertiser).permit!
  end

end
