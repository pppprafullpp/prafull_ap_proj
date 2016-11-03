class AdvertisersController < ApplicationController

  before_filter :authenticate_advertiser!
  def index
    @current_advertisers_data = current_advertiser
  end
end
