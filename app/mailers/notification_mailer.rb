class NotificationMailer < ApplicationMailer

  def welcome_mail (type,id)
    @user = eval(type.titleize).find(id)
    activation_token = @user.token
    # mailing_url = AppConfiguration.find_by_config_key("mailing url").config_value
    mailing_url = "http://103.243.5.242:4000"
    @link = "#{mailing_url}/activate?type=#{type}&id=#{id}&token=#{activation_token}"
    subject = "Welcome to Social Booker"
    mail(:to=>@user.email,:subject=>subject).deliver!
  end

  def reset_password(type,email)
    @type = type
    @user = eval(type.camelcase).find_by_email(email)
    mail(:to=>@user.email,:subject=>"SocialBooker:Password reset").deliver!
  end
end
