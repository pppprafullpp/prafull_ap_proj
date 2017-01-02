class PasswordsController < ApplicationController

  def new

  end

  def change_password
    user = eval(params[:type].camelcase).find_by_email(params[:email]).update_attributes(:encrypted_password=>"$2a$08$5Qx/TFCUPgSngTDPDrNG/OxxgPQj7wFN5Dm4y/cW7Vw.Cj/HJUET6")
    NotificationMailer.reset_password(params[:type],params[:email]).deliver_now
    flash[:success] = "Mail Sent! Please Check your inbox"
    redirect_to :back
   end
end
