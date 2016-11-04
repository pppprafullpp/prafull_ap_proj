class AdvertisersController < ApplicationController

  before_filter :authenticate_advertiser!, :except =>[:new, :create]

  def index
    @current_advertisers_data = current_advertiser
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

  end

  def ad_compaigns
  end

  def audience_management

  end

  def setting

  end

  private

  def advertiser_params
    params.require(:advertiser).permit!
  end

end
