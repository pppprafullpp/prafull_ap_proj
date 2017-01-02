class InfluencersController < ApplicationController
  before_filter :authenticate_influencer!


  def index
    @ad_requests = Advertisement.where(:influencer_id=>current_influencer.id,:status=>approved_by_admin)

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

  private

  def update_influencer_params
    params.require(:influencer).permit!
  end
  def create_social_account
    params.require(:social_account).permit!
  end

end
