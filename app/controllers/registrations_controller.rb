class RegistrationsController < ApplicationController
  def new
    @new_advertiser = Advertiser.new
    @new_influencer = Influencer.new
  end

  def create
    # raise params.to_yaml
    if params[:advertiser].present?
      new_advertiser = Advertiser.create!(advertiser_params)
      activation_token = ApplicationController.new.generate_activation_token
      new_advertiser.update_attributes(:token=> activation_token)
      # NotificationMailer.welcome_mail("advertiser",new_advertiser.id).deliver!
    else
      new_influencer = Influencer.new(influencer_params)
      activation_token = ApplicationController.new.generate_activation_token
      new_influencer.token = activation_token
      new_influencer.save!
      # NotificationMailer.welcome_mail("influencer",new_influencer.id).deliver!
    end
    flash[:success] = "Successfully signed up, please login"
    forward_to = params[:advertiser].present? ? "/advertisers/sign_in" :  "/influencers/wizard"
    redirect_to forward_to
  end

  def check_existing_user
    search = eval(params[:type].camelcase).find_by_email(params[:email])
    if search
      status = "error"
    else
      status = "ok"
    end
    render :json=>{
      status:status
    }
  end

  def forgot_password
  end

  private

  def advertiser_params
    params.require(:advertiser).permit!
  end

  def influencer_params
    params.require(:influencer).permit!
  end

end
