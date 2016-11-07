class RegistrationsController < ApplicationController
  def new
    @new_advertiser = Advertiser.new
    @new_influencer = Influencer.new
  end

  def create
    # raise params.to_yaml
    if params[:advertiser].present?
      Advertiser.create!(advertiser_params)
    else
      Influencer.create!(influencer_params)
    end
    flash[:success] = "Successfully signed up, please login"
    redirect_to root_path
  end

  private

  def advertiser_params
    params.require(:advertiser).permit!
  end

  def influencer_params
    params.require(:influencer).permit!
  end

end
