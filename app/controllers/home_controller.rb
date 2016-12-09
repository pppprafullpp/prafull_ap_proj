class HomeController < ApplicationController

  def index
  end

  def activate
    saved_token = eval(params[:type].titleize).find(params[:id]).token
    recieved_token = params[:token]
     if saved_token == recieved_token
       eval(params[:type].titleize).find(params[:id]).update_attributes(:is_verified => true)
       flash[:success] = "Successfully verified"
       redirect_to "/#{params[:type]}s/sign_in"
     else
       flash[:success] = "token invalid, new token will be issued and send to you"
     end
  end
end
