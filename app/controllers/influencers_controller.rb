class InfluencersController < ApplicationController
  before_filter :authenticate_influencer!


  def index
  end

  def ad_requests
  end

  def change_password
  end

  def setting
    @new_social_account = SocialAccount.new
    @social_accounts = current_influencer.social_account
  end

  def add_social_account_details
    # raise params.to_yaml
    if current_influencer.social_account.present?
      flash[:success] = "Social Account Already exists"
    else
      SocialAccount.create!(create_social_account)
      flash[:success] = "Successfully created"

    end
        redirect_to :back
  end

  private

  def create_social_account
    params.require(:social_account).permit!
  end

end
