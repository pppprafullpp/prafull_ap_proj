class HomeController < ApplicationController

  def index
    if params[:code].present?
      $instagram_access_code = params[:code]
      flash[:success] = "Logged In Successfully"
      redirect_to "/influencers"
    end
  end

  def activate
    saved_token = eval(params[:type].titleize).find(params[:id]).token
    recieved_token = params[:token]
     if saved_token == recieved_token
       eval(params[:type].titleize).find(params[:id]).update_attributes(:is_verified => true)
       flash[:success] = "Successfully verified"
       redirect_to "/#{params[:type]}s/"
     else
       flash[:success] = "token invalid, new token will be issued and send to you"
     end
  end

  def check_email_existing
      old_user = eval(params[:type].camelcase).find_by_email(params[:email])
      if old_user
        present = true
      else
        present = false
    end
    render :json=> {
        :success => true,
        :present => present
    }
  end
end
