class InfluencersController < ApplicationController
  before_filter :authenticate_influencer!


  def index
  end

  def ad_compaigns
  end

  def change_password
  end

  def setting
    @new_social_account = SocialAccount.new
    @social_accounts = current_influencer.social_accounts
  end

  def add_social_account_details
    # raise params.to_yaml
    SocialAccount.create!(create_social_account)
    flash[:success] = "Successfully created"
    redirect_to :back
  end

  private

  def create_social_account
    params.require(:social_account).permit!
  end
end
